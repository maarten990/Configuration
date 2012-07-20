(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(evil evil-surround
                      magit
                      projectile
                      monokai-theme moe-theme
                      auctex
                      ido-vertical-mode ido-ubiquitous smex
                      dtrt-indent
                      haskell-mode
                      company company-irony
                      yasnippet
                      anaconda-mode company-anaconda
                      expand-region
                      exec-path-from-shell
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;;;;; local packages ;;;;;;
(add-to-list 'load-path "~/.emacs.d/local")
(add-to-list 'custom-theme-load-path "~/.emacs.d/local/themes")

; fix path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; appearance
(add-to-list 'default-frame-alist '(font . "Menlo-12"))
(setq evil-default-cursor t)
(load-theme 'moe-dark t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(column-number-mode 1)
(setq inhibit-startup-message t)
(setq-default fill-column 80)

;; no backup stuff
(setq make-backup-files nil)
(setq auto-save-default nil)

;; indent with 4 spaces
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; scroll by line
(setq scroll-step            1
      scroll-conservatively  10000)

;; enable modes
(setq evil-want-C-u-scroll t)
(evil-mode t)
(global-evil-surround-mode t)
(projectile-global-mode)
(dtrt-indent-mode t)
(electric-indent-mode t)
(electric-pair-mode t)
(yas-global-mode t)
(ido-mode t)
(ido-vertical-mode t)
(ido-ubiquitous-mode t)

;; addon settings
(setq org-hide-emphasis-markers t)
(setq org-startup-indented t)
(setq org-pretty-entities t)
(setq org-agenda-files '("~/Dropbox/Org/"))

(setq ido-use-faces nil)
(setq ido-enable-flex-matching t)

(setq-default preview-scale-function 1.2) ; larger auctex previews

;; hooks
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(eval-after-load 'company
  '(progn
    (add-to-list 'company-backends 'company-irony)
    (add-to-list 'company-backends 'company-anaconda)))

(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))

;; custom functions and bindings
(global-set-key (kbd "C-x C-o") 'company-complete)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-=") 'er/expand-region)

(defun org-notes (file)
  (interactive
   (let ((files (directory-files "~/Dropbox/Org/" nil ".*\.org")))
     (list
      (ido-completing-read "Open file: " files))))
  (find-file (concat "~/Dropbox/Org/" file)))
