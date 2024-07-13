
(let ((default-directory user-emacs-directory))
  (normal-top-level-add-subdirs-to-load-path))

(setq custom-file "~/.emacs.d/custom.el")

(require 'init-packages)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))
(global-subword-mode 1)
; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

(setq-default indent-tabs-mode nil)

(setq scroll-preserve-screen-position t)
(setq undo-limit 90000000)

;; (require 'highlight-symbol)
;; (global-set-key (kbd "C-c h") 'highlight-symbol)
;; (global-set-key (kbd "C-c n") 'highlight-symbol-next)
;; (global-set-key (kbd "C-c p") 'highlight-symbol-prev)

(el-get-bundle 'magit)

(setq mouse-wheel-scroll-amount '(3))
(setq mouse-wheel-progressive-speed nil)


(require 'init-shortcuts)
(require 'init-visual)
(require 'init-mode-line)
(require 'init-auto-complete)
;; (require 'init-clojure)
;; (require 'init-common-lisp)
(require 'init-paredit)
(require 'init-ido)
;; (require 'init-haskell)
;; (require 'init-webmode)
;; (require 'init-go)
;; (require 'init-tiling)
;; (require 'init-python)
(require 'init-markdown)

(load custom-file 'noerror)
(provide 'init)
(put 'erase-buffer 'disabled nil)
