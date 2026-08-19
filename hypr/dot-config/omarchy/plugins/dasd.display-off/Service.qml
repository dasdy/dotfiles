import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland

// Replacement for the old hypridle DPMS listener. Omarchy's built-in
// omarchy.idle service only knows screensaver and lock timeouts, and quattro
// folded display power-off into the lock screen itself. With `idle.lock`
// pushed out of reach in shell.json, nothing blanks the panels — this does.
//
// The IdleMonitor alone is not enough to time this: launching the screensaver
// makes the compositor report activity, and the screensaver terminal keeps
// emitting the odd blip afterwards. Every one of those would restart a bare
// IdleMonitor countdown. So the monitor is used only to detect the *start* of
// an idle stretch, and a plain timer counts down from there; activity that
// arrives while a screensaver window is up is ignored, exactly as the
// first-party omarchy.idle service does.
Item {
  id: root

  // Injected by omarchy-shell (the first-party service loader).
  property var shell: null

  readonly property string stayAwakeStateDir: Quickshell.env("HOME") + "/.local/state/omarchy/indicators"
  readonly property var idleConfig: shell && shell.shellConfig && shell.shellConfig.idle ? shell.shellConfig.idle : ({})
  readonly property int defaultTimeoutSeconds: 900
  // Tunable as `idle.displayOff` in ~/.config/omarchy/shell.json, alongside
  // the screensaver and lock timings the first-party idle service reads.
  readonly property int timeoutSeconds: secondsFromConfig(idleConfig.displayOff, defaultTimeoutSeconds)
  // Short window used to notice idling has begun; the rest is on countdownTimer.
  readonly property int detectSeconds: Math.min(60, timeoutSeconds)
  readonly property int countdownSeconds: Math.max(0, timeoutSeconds - detectSeconds)
  readonly property bool idleEnabled: stayAwakeStateLoaded && !stayAwake
  readonly property string screensaverClass: "org.omarchy.screensaver"

  // Hyprland 0.56 routes dispatchers through Lua and rejects the old
  // `dispatch dpms off` string form outright (exit 7, "')' expected near
  // 'off'"). Prefer the Lua call and fall back to the legacy form on older
  // versions, the same way omarchy-launch-screensaver hedges its dispatches.
  //
  // The argument must be a table keyed `action` — that is what the binding's
  // tableToggleAction() reads. A bare string, or any other shape, is silently
  // accepted, ignored, and treated as TOGGLE_ACTION_TOGGLE: `hl.dsp.dpms("on")`
  // returns "ok" and flips the panels off if they happened to be on. Only the
  // table form is idempotent, which is what a timer-driven service needs.
  readonly property string dpmsOffCommand: "hyprctl dispatch 'hl.dsp.dpms({ action = \"disable\" })' || hyprctl dispatch dpms off"
  readonly property string dpmsOnCommand: "hyprctl dispatch 'hl.dsp.dpms({ action = \"enable\" })' || hyprctl dispatch dpms on"
  readonly property string dpmsProbeCommand: "hyprctl monitors -j | jq -r '[.[] | .name + \"=\" + (.dpmsStatus|tostring)] | join(\",\")'"

  property bool stayAwake: false
  property bool stayAwakeStateLoaded: false
  property bool displayOff: false
  property string probeLabel: ""
  property var screensaverWindows: ({})
  property int screensaverWindowCount: 0

  function secondsFromConfig(value, fallback) {
    var n = Number(value)
    if (!isFinite(n) || n <= 0) return fallback
    return Math.floor(n)
  }

  function logEvent(event) {
    console.log("dasd display-off " + new Date().toISOString() + " " + event)
  }

  function runProcess(process, command) {
    if (process.running) return
    process.command = ["bash", "-lc", command]
    process.running = true
  }

  function blank() {
    if (root.displayOff) return
    root.displayOff = true
    logEvent("dpms off after " + root.timeoutSeconds + "s idle")
    runProcess(dpmsOffProcess, root.dpmsOffCommand)
  }

  function unblank(reason) {
    if (!root.displayOff) return
    root.displayOff = false
    logEvent("dpms on: " + reason)
    runProcess(dpmsOnProcess, root.dpmsOnCommand)
  }

  function probeDpms(label) {
    root.probeLabel = label
    runProcess(dpmsProbeProcess, root.dpmsProbeCommand)
  }

  function arm() {
    if (!root.idleEnabled || root.displayOff || countdownTimer.running) return
    if (root.countdownSeconds === 0) {
      root.blank()
      return
    }
    logEvent("armed: blanking in " + root.countdownSeconds + "s")
    countdownTimer.restart()
  }

  function disarm(reason) {
    cancelGraceTimer.stop()
    if (!countdownTimer.running) return
    logEvent("disarmed: " + reason)
    countdownTimer.stop()
  }

  // Activity while the screensaver is up is usually the screensaver itself, so
  // the countdown survives it. Real activity either dismisses the screensaver
  // (handled below) or arrives before one exists.
  function handleActive() {
    if (root.displayOff) {
      // Someone is clearly there. Wake the panels now and let the normal idle
      // path re-arm if this turns out to have been a stray signal.
      disarm("woken")
      unblank("activity")
      return
    }

    if (!countdownTimer.running) return
    cancelGraceTimer.restart()
  }

  function handleIdleChanged() {
    if (idleMonitor.isIdle) root.arm()
    else root.handleActive()
  }

  function setScreensaverWindow(address, visible) {
    if (!address) return

    var next = {}
    for (var key in root.screensaverWindows) {
      if (key !== address) next[key] = true
    }
    if (visible) next[address] = true

    var count = 0
    for (var seen in next) count++

    root.screensaverWindows = next
    root.screensaverWindowCount = count
  }

  function handleScreensaverWindowClosed(address) {
    setScreensaverWindow(address, false)
    if (root.screensaverWindowCount > 0) return

    // The screensaver only goes away on real input.
    disarm("screensaver-dismissed")
    unblank("screensaver-dismissed")
  }

  function eventParts(event, count) {
    try {
      if (event && event.parse) return event.parse(count)
    } catch (error) {
    }
    return String(event && event.data ? event.data : "").split(",")
  }

  function handleHyprlandEvent(event) {
    var name = String(event && event.name ? event.name : "")
    if (name === "openwindow") {
      var open = eventParts(event, 4)
      if (String(open[2] || "") === root.screensaverClass) {
        setScreensaverWindow(open[0], true)
        cancelGraceTimer.stop()
      }
    } else if (name === "closewindow") {
      var close = eventParts(event, 1)
      var address = String(close[0] || "")
      if (root.screensaverWindows[address]) handleScreensaverWindowClosed(address)
    }
  }

  function applyStayAwake(value) {
    var enabled = !!value
    var changed = !root.stayAwakeStateLoaded || root.stayAwake !== enabled

    root.stayAwake = enabled
    root.stayAwakeStateLoaded = true

    if (!changed) return

    logEvent("stay-awake " + (enabled ? "enabled" : "disabled"))
    if (enabled) {
      disarm("stay-awake")
      unblank("stay-awake")
    } else {
      Qt.callLater(root.handleIdleChanged)
    }
  }

  function refreshStayAwakeState() {
    if (!stayAwakeStateProbe.running) stayAwakeStateProbe.running = true
  }

  IdleMonitor {
    id: idleMonitor
    enabled: root.idleEnabled
    timeout: root.detectSeconds
    respectInhibitors: true
    onIsIdleChanged: root.handleIdleChanged()
  }

  Timer {
    id: countdownTimer
    interval: root.countdownSeconds * 1000
    repeat: false
    onTriggered: if (root.idleEnabled) root.blank()
  }

  // The screensaver's openwindow event can trail the activity it causes, so
  // give it a moment before treating that activity as a reason to stand down.
  Timer {
    id: cancelGraceTimer
    interval: 3000
    repeat: false
    onTriggered: {
      if (root.screensaverWindowCount > 0) return
      if (idleMonitor.isIdle) return
      root.disarm("activity")
    }
  }

  Connections {
    target: Hyprland
    function onRawEvent(event) { root.handleHyprlandEvent(event) }
  }

  // Both dispatches used to run into the void: no exit code, no stderr. That
  // is how a hard failure sat unnoticed in the log for days, with only the
  // "dpms off" line above to suggest anything had happened. Report the result.
  Process {
    id: dpmsOffProcess
    stderr: SplitParser {
      onRead: function(line) { root.logEvent("dpms off stderr: " + String(line).trim()) }
    }
    onExited: function(exitCode) {
      if (exitCode !== 0) root.logEvent("dpms off FAILED: exitCode=" + exitCode)
      else root.probeDpms("after off")
    }
  }

  Process {
    id: dpmsOnProcess
    stderr: SplitParser {
      onRead: function(line) { root.logEvent("dpms on stderr: " + String(line).trim()) }
    }
    onExited: function(exitCode) {
      if (exitCode !== 0) root.logEvent("dpms on FAILED: exitCode=" + exitCode)
      else root.probeDpms("after on")
    }
  }

  // Confirms the compositor agrees the panels went down, so the log records
  // the outcome rather than the intent.
  Process {
    id: dpmsProbeProcess
    stdout: SplitParser {
      onRead: function(line) { root.logEvent("monitors " + root.probeLabel + ": " + String(line).trim()) }
    }
  }

  Process {
    id: stayAwakeStateProbe
    command: ["bash", "-c", "mkdir -p \"$HOME/.local/state/omarchy/indicators\"; if [[ -f $HOME/.local/state/omarchy/indicators/stay-awake ]]; then echo yes; else echo no; fi"]
    stdout: SplitParser {
      onRead: function(line) { root.applyStayAwake(String(line).trim() === "yes") }
    }
    onExited: function() { stayAwakeStateDirWatcher.reload() }
  }

  FileView {
    id: stayAwakeStateDirWatcher
    path: root.stayAwakeStateDir
    watchChanges: true
    printErrors: false
    onFileChanged: root.refreshStayAwakeState()
  }

  Component.onCompleted: {
    logEvent("service-ready")
    refreshStayAwakeState()
  }

  IpcHandler {
    target: "displayOff"

    function status(): string {
      return JSON.stringify({
        enabled: root.idleEnabled,
        stayAwake: root.stayAwake,
        timeout: root.timeoutSeconds,
        detect: root.detectSeconds,
        idle: idleMonitor.isIdle,
        armed: countdownTimer.running,
        screensaverWindows: root.screensaverWindowCount,
        displayOff: root.displayOff
      })
    }

    function blank(): string {
      root.disarm("ipc")
      root.blank()
      return "off"
    }
  }
}
