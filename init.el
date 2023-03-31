;; Emacs stuff
;; ===========

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(magit projectile-ripgrep projectile which-key ivy use-package)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Package system setup
;; ====================

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			("org" . "https://orgmode.org/elpa/")
			("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package) ;; For non-Linux platforms
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-ensure t)


;; Keybinding configuration
;; ========================

(setq mac-command-modifier 'control) ;; Re-bind C to mac Cmd key


;; Basic UI Configuration
;; ======================

(setq inhibit-startup-message t) ;; Open on scratch buffer instead of startup screen

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)     
(menu-bar-mode -1)

(column-number-mode)

(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-face-attribute 'default nil :family "iA Writer Mono S" :height 160)
(set-face-attribute 'fixed-pitch nil :family "iA Writer Mono S" :height 160)
(set-face-attribute 'variable-pitch nil :family "iA Writer Mono V" :height 160 :weight 'regular)

(global-display-line-numbers-mode t)

(setq-default display-line-numbers-width 3)
(setq-default display-line-numbers-widen t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


;; File management
;; ===============

(setq dired-kill-when-opening-new-dired-buffer t) ;; Restrict dired buffers to one

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))


;; Advanced UI Configuration
;; =========================

(use-package diminish)

(use-package doom-themes
  :config
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package ivy
  :init (ivy-mode)
  :diminish 'ivy-mode)

(use-package which-key
  :init (which-key-mode)
  :diminish 'which-key-mode
  :config (setq which-key-idle-delay 2))

(use-package magit)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Ernest/Projects")
    (setq projectile-project-search-path '(("~/Ernest/Projects" . 3))))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package projectile-ripgrep)


;; JavaScript
;; ==========

(setq js-indent-level 2) ;; Set indents in js mode to 2


;; CSS/SCSS
;; ========

(setq css-indent-offset 2) ;; Set indents in css/scss mode to 2
