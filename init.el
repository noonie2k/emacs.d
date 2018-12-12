;;; init.el --- Summary
;;; Commentary:

;;; Code:

;; Packages come from Nix
(require 'package)
(setq package-archives nil
      package-enable-at-startup nil)
(package-initialize)

;; Customize System
(setq custom-file (expand-file-name "customize.el" user-emacs-directory))
(load custom-file)

;; Defaults
(setq-default fill-column 80
	          indent-tabs-mode nil
	          org-src-tab-acts-natively t
	          tab-width 4)

;;;;;;;;;;;;;;;;
;; Behaviours ;;
;;;;;;;;;;;;;;;;

;;
;; Backups
;;
(use-package files
  :config
  (setq-default backup-by-copying t
		        backup-directory-alist `(("." . ,temporary-file-directory))
		        delete-old-versions t
		        version-control t))

;;
;; Buffers
;;
(global-set-key [remap kill-buffer] #'kill-this-buffer)

;;
;; Confirmations
;;
(defalias 'yes-or-no-p 'y-or-n-p)

;;
;; Encryption
;;
(use-package epa-file
  :config
  (epa-file-enable))

;;;;;;;;;;;;;;;;
;; Appearance ;;
;;;;;;;;;;;;;;;;

;;
;; Colors
;;
(use-package rainbow-mode
  :diminish
  :hook prog-mode)

;;
;; Disable superfluous UI elements
;;
(blink-cursor-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

;;
;; Theme
;;
(use-package zerodark-theme
  :config
  (load-theme 'zerodark t))

;;;;;;;;;;;;;;;;;;
;; Code Editing ;;
;;;;;;;;;;;;;;;;;;

;;
;; Checking
;;
(use-package flycheck
  :diminish
  :config
  (global-flycheck-mode t))

;;
;; Completion
;;
(use-package company
  :diminish
  :config
  (progn
    (global-company-mode t)
    (setq-default company-idle-delay 0.2
		          company-minimum-prefix-length 2
		          company-require-match nil
		          company-tooltip-align-annotations t)))

(use-package counsel
  :diminish
  :config
  (counsel-mode t))

;;
;; Highlights
;;
(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook (prog-mode . highlight-indent-guides-mode)
  :config
  (setq-default highlight-indent-guides-method 'character))

(use-package hl-line
  :config
  (global-hl-line-mode t))

(use-package hi-lock
  :hook (prog-mode . hi-lock-mode))

;;
;; Line Numbers
;;
(use-package display-line-numbers
  :hook (prog-mode . display-line-numbers-mode))

;;
;; Navigation
;;
(use-package ivy
  :diminish
  :config
  (ivy-mode t)
  :init
  (setq-default ivy-use-virtual-buffers t
		        enable-recursive-minibuffers t))

;;
;; Parens
;;
(use-package paredit
  :hook ((emacs-lisp-mode . paredit-mode)
         (clojure-mode . paredit-mode)))

;;
;; Project Management
;;
(use-package projectile
  :diminish
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package counsel-projectile
  :commands counsel-projectile-mode
  :init
  (setq counsel-projectile-mode t))

(counsel-projectile-mode)

;;
;; Searching
;;
(use-package swiper
  :bind (("C-s" . swiper)
	     ("C-s-s" . isearch-forward)))

;;
;; Selections
;;
(use-package expand-region
  :bind (("C-=" . er/expand-region)
	     ("C--" . er/contract-region)))

;;
;; Snippets
;;
(use-package autoinsert
  :config
  (auto-insert-mode t))

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets)

(use-package yatemplate)

;;
;; Version Control
;;
(use-package magit
  :bind ("C-x g" . magit-status))

;;;;;;;;;;;;;;;;;;;;;;;
;; Language Specific ;;
;;;;;;;;;;;;;;;;;;;;;;;

;;
;; Clojure
;;
(use-package clojure-mode)
(use-package cider)

;;
;; Coffeescript
;;
(use-package coffee-mode)

;;
;; Nix
;;
(use-package nix-mode
  :config
  (setq nix-indent-function 'nix-indent-line))

;;
;; Ruby
;;
(use-package robe
  :hook (ruby-mode . robe-mode)
  :config (add-to-list 'company-backends 'company-robe))

(use-package poly-erb)
;;
;; Terraform
;;
(use-package terraform
  :hook (terraform-mode . terraform-format-on-save-mode))

(use-package company-terraform
  :hook (terraform-mode . company-terraform-init))

;;;;;;;;;;;;;;
;; Features ;;
;;;;;;;;;;;;;;

;;
;; ReST Client
;;
(use-package restclient
  :mode ("\\.http\\'" . restclient-mode))

;;
;; Which Key
;;
(use-package which-key
  :diminish
  :config
  (which-key-mode t))

;;
;; Servers
;;
(use-package atomic-chrome
  :config
  (atomic-chrome-start-server))

(use-package server
  :config
  (server-start))

(provide 'init)
;;; init.el ends here
