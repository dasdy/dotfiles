(el-get-bundle! 'elpy)


(elpy-enable)
;; (elpy-use-ipython)и
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

(setq elpy-rpc-python-command "python3")
;(setq python-shell-shell-interpreter "python") 

;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "-i")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")
(provide 'init-python)
