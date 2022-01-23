(setq gc-cons-threshold (* 50 1000 1000))

(defun mk/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'mk/display-startup-time)

(setq user-full-name "Mert Kutay"
      user-mail-address "mertckutay@gmail.com")
(setq auth-sources '("~/.authinfo"))

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-verbose t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))

(use-package exec-path-from-shell
  :defer t
  :init
  (setq exec-path-from-shell-arguments nil)
  (when (display-graphic-p)
    (exec-path-from-shell-initialize)))

(use-package server
  :config
  (when (not (server-running-p))
      (server-start)))

(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(global-auto-revert-mode 1)

(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 10)
(save-place-mode)

(column-number-mode)
(global-display-line-numbers-mode)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                treemacs-mode-hook
                term-mode-hook
                vterm-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda ()
                   (display-line-numbers-mode 0))))

(defun mk/setup-fonts ()
  (set-face-attribute 'default nil :font "SauceCodePro Nerd Font Mono" :height 150)
  (set-frame-width (selected-frame) 100)
  (setq doom-modeline-height 15))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (mk/setup-fonts))))
  (mk/setup-fonts))

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(modify-syntax-entry ?_ "w")
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(use-package general
  :after evil
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-redo)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-window-map (kbd "C-h") 'evil-window-left)
  (define-key evil-window-map (kbd "C-j") 'evil-window-down)
  (define-key evil-window-map (kbd "C-k") 'evil-window-up)
  (define-key evil-window-map (kbd "C-l") 'evil-window-right)
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-mc
  :after evil
  :config (global-evil-mc-mode)
  (evil-define-minor-mode-key '(normal visual) 'evil-mc-mode
    (kbd "C-n") 'evil-mc-make-and-goto-next-match
    (kbd "C-t") 'evil-mc-skip-and-goto-next-match
    (kbd "C-p") 'evil-mc-make-and-goto-prev-match))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode))

(defun disable-pair-for-tempo ()
  (setq-local electric-pair-inhibit-predicate
              `(lambda (c)
                 (if (char-equal c ?<)
                     t (,electric-pair-inhibit-predicate c)))))

(use-package electric
  :init (electric-pair-mode)
  :config (setq-default electric-pair-inhibit-predicate
                        'electric-pair-conservative-inhibit)
  :hook (org-mode . disable-pair-for-tempo))

(use-package doom-themes
  :init (load-theme 'doom-gruvbox t))

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode))

(setq scroll-step 1
      scroll-margin 1
      scroll-conservatively 100000)

(use-package which-key
  :defer t
  :init (which-key-mode)
  :diminish
  :config (setq which-key-idle-delay 0.3))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config (ivy-mode))

(use-package ivy-rich
  :after ivy
  :init (ivy-rich-mode))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config (counsel-mode))

(use-package ivy-prescient
  :after counsel
  :init (setq prescient-filter-method '(literal regexp fuzzy))
  :config
  (ivy-prescient-mode t)
  (prescient-persist-mode t))



(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(rune/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-set-bar 'under)
  (setq x-underline-at-descent-line t)
  (centaur-tabs-group-by-projectile-project)
  :bind
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward))
  :hook (dired-mode . centaur-tabs-local-mode))

(defvar mk/dired-hidden nil)

(defun mk/dired-hidden-switch ()
  (interactive)
  (if mk/dired-hidden
      (setq mk/dired-hidden nil)
    (setq mk/dired-hidden t))
  (mk/dired-ls)
  (revert-buffer))

(defun mk/dired-ls ()
  (if mk/dired-hidden
      (dired-sort-other "-gho --group-directories-first")
    (dired-sort-other "-agho --group-directories-first")))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :config
  (setq trash-directory "~/.Trash")
  (setq delete-by-moving-to-trash t)
  (setq dired-kill-when-opening-new-dired-buffer t)
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file
    "H" 'mk/dired-hidden-switch))

(add-hook 'dired-mode-hook 'mk/dired-ls)

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(defun mk/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
  :hook (org-mode . mk/org-mode-setup)
  :config
  (setq org-ellipsis " ")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-directory "~/org/")
  (setq org-agenda-files
        '("~/org/Tasks.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "PROGRESS(p)" "|" "DONE(d!)")))

  (setq org-refile-targets
    '(("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj"))))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun mk/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode))

(use-package visual-fill-column
  :hook (org-mode . mk/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t)
     (python . t)))
  (setq org-confirm-babel-evaluate nil))

(defun mk/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.dotfiles/.emacs.d/Emacs.org"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook 'mk/org-babel-tangle-config)))

(with-eval-after-load 'org
  (require 'org-tempo)

  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  (add-to-list 'org-structure-template-alist '("py" . "src python")))

(use-package flycheck
  :defer t
  :init (global-flycheck-mode))

(use-package format-all
  :hook (prog-mode . format-all-mode)
  (format-all-mode . format-all-ensure-formatter))

(use-package evil-nerd-commenter
  :after evil)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package yasnippet
  :defer t)

(defun mk/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . mk/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :after lsp)

(use-package lsp-ivy
  :after lsp)

(use-package dap-mode
  :defer t)

(use-package python-mode
  :hook (python-mode . lsp-deferred)
  :custom
  (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (setq python-shell-interpreter "python3")
  (setq python-indent-offset 4)
  (require 'dap-python))

(use-package pyvenv
  :after python-mode
  :config
  (pyvenv-mode 1))

;; (use-package pyvenv
;; :after python-mode
;; :config
;; (setq pyvenv-mode-line-indicator
;; '(pyvenv-virtual-env-name
;; ("[venv:" pyvenv-virtual-env-name "] ")))
;; (pyvenv-mode))

;; (defvar mk/venv-dir)
;; (defvar mk/venv-changed nil)

;; (defun mk/check-venv ()
;; (let ((venv-dir (concat (projectile-project-root) ".venv")))
;; (when (file-directory-p venv-dir)
;; (setq mk/venv-dir venv-dir)
;; (pyvenv-activate mk/venv-dir)
;; (setq mk/venv-changed t))))

;; (add-hook 'projectile-after-switch-project-hook 'mk/check-venv)

;; (defun mk/update-venv ()
;; (when mk/venv-changed
;; (call-interactively #'lsp-workspace-restart)
;; (setq mk/venv-changed nil)))

;; (add-hook 'lsp-mode-hook 'mk/update-venv)

(use-package lsp-pyright
  :after (python-mode lsp-mode))

(use-package poetry
  :after python-mode
  :config
  (setq poetry-tracking-strategy 'switch-buffer)
  (poetry-tracking-mode))

(use-package py-isort
  :after python-mode
  :hook (before-save . py-isort-before-save))

(use-package ein
  :after python-mode)

(use-package typescript-mode
  :mode ("\\.js\\'"
         "\\.ts\\'")
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package yaml-mode
  :mode ("\\.yml\\'"
         "\\.yaml\\'"))

(use-package dockerfile-mode
  :mode ("\\Dockerfile\\'"
         "\\.dockerfile\\'"))

(use-package docker
  :bind ("C-c d" . docker))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
        ("<tab>" . company-complete-selection))
  (:map lsp-mode-map
        ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package company-prescient
  :after company
  :init (setq company-prescient-sort-length-enable nil)
  :config (company-prescient-mode t))

(use-package projectile
  :diminish projectile-mode
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '("~/projects")))
  :config (projectile-mode))

(use-package counsel-projectile
  :after projectile
  :init
  (setq counsel-projectile-sort-files t)
  :config (counsel-projectile-mode)
  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((default counsel-projectile-switch-project-action-dired))))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit)

(use-package git-gutter
  :defer t
  :init (global-git-gutter-mode)
  :custom
  (git-gutter:update-interval 2))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
  (setq vterm-max-scrollback 10000))

(defun mk/configure-shell ()
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-normalize-keymaps)

  (setq eshell-history-size 10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell
  :hook (eshell-first-time-mode . mk/configure-shell)
  :config
  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))
  (eshell-git-prompt-use-theme 'robbyrussell))

(use-package eshell-git-prompt
  :after eshell)

(setq gc-cons-threshold (* 2 1000 1000))
