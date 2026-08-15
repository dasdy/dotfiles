import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// Replacement for the old hypridle DPMS listener. Omarchy's built-in
// omarchy.idle service only knows screensaver and lock timeouts, and quattro
// folded display power-off into the lock screen itself. With `idle.lock`
// pushed out of reach in shell.json, nothing blanks the panels — this does.
Item {
  id: root

  // Injected by omarchy-shell (the first-party service loader).
  property var shell: null

  readonly property string stayAwakeStateDir: Quickshell.env("HOME") + "/.local/state/omarchy/indicators"
  readonly property int timeoutSeconds: 1800
  readonly property bool idleEnabled: stayAwakeStateLoaded && !stayAwake

  property bool stayAwake: false
  property bool stayAwakeStateLoaded: false
  property bool displayOff: false

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
    runProcess(dpmsOffProcess, "hyprctl dispatch dpms off")
  }

  function unblank(reason) {
    if (!root.displayOff) return
    root.displayOff = false
    logEvent("dpms on: " + reason)
    runProcess(dpmsOnProcess, "hyprctl dispatch dpms on")
  }

  function handleIdleChanged() {
    if (idleMonitor.isIdle) {
      if (root.idleEnabled) root.blank()
    } else {
      root.unblank("activity")
    }
  }

  function applyStayAwake(value) {
    var enabled = !!value
    var changed = !root.stayAwakeStateLoaded || root.stayAwake !== enabled

    root.stayAwake = enabled
    root.stayAwakeStateLoaded = true

    if (!changed) return

    logEvent("stay-awake " + (enabled ? "enabled" : "disabled"))
    if (enabled) root.unblank("stay-awake")
  }

  function refreshStayAwakeState() {
    if (!stayAwakeStateProbe.running) stayAwakeStateProbe.running = true
  }

  IdleMonitor {
    id: idleMonitor
    enabled: root.idleEnabled
    timeout: root.timeoutSeconds
    respectInhibitors: true
    onIsIdleChanged: root.handleIdleChanged()
  }

  Process { id: dpmsOffProcess }
  Process { id: dpmsOnProcess }

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
        idle: idleMonitor.isIdle,
        displayOff: root.displayOff
      })
    }
  }
}
