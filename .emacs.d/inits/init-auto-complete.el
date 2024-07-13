(el-get-bundle auto-complete)
(global-auto-complete-mode)

(setq ac-auto-start t)

(global-set-key (kbd "C-<tab>") 'auto-complete)
(global-set-key (kbd "M-n") 'ac-expand)
(global-set-key (kbd "M-p") 'ac-previous)

(provide 'init-auto-complete)
