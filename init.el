(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(tool-bar-mode -1)
(setq column-number-mode t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq size-indication-mode t)
(set-locale-environment "de_DE.utf-8")
(set-face-background 'default "black")
(set-face-foreground 'default "white")
(set-face-background 'cursor "green")
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package) (package-install 'use-package))
(eval-when-compile (require 'use-package))
(use-package gnu-elpa-keyring-update
  :custom
  (use-package-always-ensure t)
  (package-check-signature 'allow-unsigned))
(use-package diminish)
(use-package emacs
  :diminish
  visual-line-mode)
(use-package autorevert
  :diminish
  auto-revert-mode)
(use-package epg
  :custom
  (epg-pinentry-mode 'loopback))
(use-package which-key
  :config (which-key-mode t)
  :diminish)
(use-package counsel
  :bind
  ("C-s" . swiper-isearch)
  ("C-x b" . counsel-switch-buffer)
  :config
  (ivy-mode t)
  (counsel-mode t)
  :diminish
  counsel-mode
  ivy-mode)
(use-package ivy-rich
  :after ivy
  :config (ivy-rich-mode t))
(use-package helpful
  :commands
  (helpful-callable
   helpful-variable
   helpful-command
   helpful-key
   helpful-at-point)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-command] . helpful-command)
  ([remap describe-key] . helpful-key)
  ("C-h C-x d" . helpful-at-point))
(use-package projectile
  :config (projectile-mode t)
  :bind-keymap ("C-c p" . projectile-command-map)
  :diminish)
(use-package counsel-projectile
  :config (counsel-projectile-mode))
(use-package magit
  :hook (magit-status-mode . turn-on-visual-line-mode))
(use-package flycheck
  :init (global-flycheck-mode))
(use-package ediff
  :defer t
  :custom-face
  (ediff-current-diff-A ((t (:extend t :background "#4d3333"))))
  (ediff-current-diff-B ((t (:extend t :background "#334d33"))))
  (ediff-current-diff-C ((t (:extend t :background "#4d4d33"))))
  (ediff-even-diff-A
    ((t (:extend t :background "#555555" :distant-foreground "White"))))
  (ediff-even-diff-C
    ((t (:extend t :background "#555555" :distant-foreground "White"))))
  (ediff-odd-diff-B
   ((t (:extend t :background "#555555" :distant-foreground "White"))))
  (ediff-fine-diff-A ((t (:extend t :background "#660000"))))
  (ediff-fine-diff-B ((t (:extend t :background "#006600"))))
  (ediff-fine-diff-C ((t (:extend t :background "#666600")))))
(use-package js
  :custom (js-indent-level 2))
(use-package org
  :custom
  (org-agenda-files (concat user-emacs-directory "org-agenda-files"))
  (org-plantuml-jar-path plantuml-jar-path)
  (org-babel-load-languages
   '((emacs-lisp . t)
     (plantuml . t)
     (shell . t)))
  :config
  (let ((filename org-agenda-files))
    (if (not (file-exists-p filename))
	(make-empty-file filename)))
  :hook ((org-mode . turn-on-visual-line-mode)
	 (org-mode . turn-on-flyspell)))
(use-package csv-mode)
(use-package yaml-mode)
(use-package bats-mode)
(use-package plantuml-mode
  :custom
  (plantuml-default-exec-mode 'jar)
  (plantuml-indent-level 2)
  (plantuml-jar-path "~/opt/plantuml.jar")
  :config
  (setq plantuml-output-type "png"))
(use-package go-mode)
(use-package markdown-mode)
(use-package groovy-mode)
(use-package powershell)
(use-package dockerfile-mode)
(use-package docker-compose-mode)
(use-package json-mode)
(use-package adoc-mode)
(use-package gnuplot)
(use-package lua-mode)
(use-package robot-mode)
(use-package pandoc-mode)
(use-package mermaid-mode
  :custom
  (mermaid-mmdc-location
   (file-truename "~/.asdf/installs/nodejs/22.0.0/bin/mmdc"))
  )
(use-package go-template-mode)
(defun alk/go-template-helper-mode-enable()
  (when (and buffer-file-name
	     (string-match-p
	      (rx "/templates/" (* any) "." (or "yaml") eos)
	      buffer-file-name))
    (go-template-helper-mode 1)))

(use-package go-template-helper-mode
  :hook
  (yaml-mode . alk/go-template-helper-mode-enable))
(use-package lsp-mode
  :custom
  (lsp-keymap-prefix "C-c l")
  :commands lsp
  :hook (
	 (sh-mode . lsp)
	 (java-mode . lsp)
	 (yaml-mode . lsp)
	 (lua-mode . lsp)
	 ))
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol
  )
(use-package lsp-java)
