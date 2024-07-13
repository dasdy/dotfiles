(el-get-bundle 'highlight-symbol)

(setq inhibit-splash-screen t)

(global-hl-line-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq highlight-symbol-idle-delay 0.2)
(setq show-paren-style 'parenthesis)
(setq visible-bell t)

(global-set-key (kbd "C-x C-p") nil)
(global-visual-line-mode t)

(add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq-local show-trailing-whitespace t)))

(add-hook 'prog-mode-hook 'highlight-symbol-mode)
(add-hook 'prog-mode-hook 'prettify-symbols-mode)
(add-hook 'prog-mode-hook 'line-number-mode)
(add-hook 'prog-mode-hook 'column-number-mode)

(set-face-attribute 'default nil :height 100)
;;(add-to-list 'default-frame-alist '(font . "Fira Code-10" ))
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-10" ))
;; (el-get-bundle 'gotham-theme)
;; (el-get-bundle 'solarized-theme)
;; (el-get-bundle 'zenburn-theme)
;; (el-get-bundle 'gruvbox-theme)
;; (el-get-bundle 'material-theme)
;; (el-get-bundle 'github-modern-theme)
;; (el-get-bundle 'github-theme)
;; (el-get-bundle 'moe-theme)
(el-get-bundle 'flatui-theme)
(setq theme-to-load 'flatui)
(load-theme theme-to-load t)

(provide 'init-visual)
