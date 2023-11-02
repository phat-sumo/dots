(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(setopt org-pretty-entities t)
(setopt org-hide-emphasis-markers t)
(org-indent-mode)

(require 'org-tempo)

(use-package org-modern
  :hook (org-ode . org-modern-mode)
  :init (global-org-modern-mode))

(use-package org-appear
  :hook (org-mode . org-appear-mode))

(use-package undo-tree
    :ensure t
    :custom ((undo-tree-auto-save-history t)
             (undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo"))))
    :config
    (global-undo-tree-mode)
)

  (use-package evil-commentary
    :config
    (evil-commentary-mode))

(use-package evil
  :demand t
  :custom
  (evil-default-cursor 'hbar)
  (evil-normal-state-cursor 'hbar)
  (evil-insert-state-cursor 'hbar)
  (evil-visual-state-cursor 'hbar)
  (evil-motion-state-cursor 'hbar)
  (evil-replace-state-cursor 'hbar)
  (evil-operator-state-cursor 'hbar)
  (evil-undo-system 'undo-tree)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump t)
  (evil-want-C-o-jump t)
  :init
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  :config
  (evil-mode))

;; might want to get rid of this someday- the package claims that emacs
;; keymaps are less convoluted and it a bit easier to work with
;; https://github.com/cofi/evil-leader
(use-package evil-leader
  :init
  (setq evil-leader/leader "<SPC>")
  (evil-leader/set-key "w" 'save-buffer
                       "x" 'save-buffers-kill-emacs
                       "q" 'kill-emacs)
  :config
  (global-evil-leader-mode))

(use-package evil-numbers
  :init
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-S-a") 'evil-numbers/dec-at-pt))

(use-package evil-org
  :ensure t
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package evil-replace-with-register
  :config
  (setq evil-replace-with-register-key (kbd "gr"))
  (evil-replace-with-register-install))

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  ;; optionally use tab for cycling, default is `corfu-complete'.
  ;; these need a little investigation first
  ;; :bind (:map corfu-map
  ;;             ("M-SPC"      . corfu-insert-separator)
  ;;             ("TAB"        . corfu-next)
  ;;             ([tab]        . corfu-next)
  ;;             ("S-TAB"      . corfu-previous)
  ;;             ([backtab]    . corfu-previous)
  ;;             ("S-<return>" . corfu-insert)
  ;;             ("RET"        . nil))
  :config
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

;; Add extensions
(use-package cape
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p h" . cape-history)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-elisp-symbol)
         ("C-c p e" . cape-elisp-block)
         ("C-c p a" . cape-abbrev)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p :" . cape-emoji)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  ;;(add-to-list 'completion-at-point-functions #'cape-history)
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
)

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
          (c-mode . lsp)
          (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)

;; necessary so the bar doesn't get weird
(use-package all-the-icons
  :ensure t)

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 10)
  (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-meltbus t)

  ;; flashing mode-line on error
  (doom-themes-visual-bell-config))

;; eventually add:
; (doom-themes-org-config)

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable the "www" ligature in every possible major mode
  (ligature-set-ligatures 't '("www"))
  ;; Enable traditional ligature support in eww-mode, if the
  ;; `variable-pitch' face supports it
  (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
  ;; Enable all Cascadia Code ligatures in programming modes
  ;; hopefully these are all in fira code too lol
  (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                      ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                      "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                      "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                      "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                      "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                      "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                      "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                      ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                      "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                      "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                      "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                      "\\\\" "://"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  (global-ligature-mode t))


;; and even more eventually
; https://discourse.doomemacs.org/t/how-to-switch-customize-or-write-themes/37

(elpaca-wait)

(toggle-scroll-bar -1)
(set-frame-font "Monoid:pixelsize=10" nil t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package ag
  :ensure t)

;; allow reopening file as root
(use-package sudo-edit
  :ensure t)

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode t))

(setq initial-scratch-message ";; oh look this is how you set this!
")

(setq help-window-select t)

;; don't follow symlinks to their real locations
(setq vc-follow-symlinks nil)

;; sane scrolling values
(setq scroll-conservatively 101)
(setq scroll-margin 3)

(pixel-scroll-precision-mode t)

(defun scratch-width ()
  (set-frame-size (selected-frame) 1900 300 t))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
    '("f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "9d29a302302cce971d988eb51bd17c1d2be6cd68305710446f658958c0640f68" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "38c0c668d8ac3841cb9608522ca116067177c92feeabc6f002a27249976d7434" "3fe1ebb870cc8a28e69763dde7b08c0f6b7e71cc310ffc3394622e5df6e4f0da" "162201cf5b5899938cfaec99c8cb35a2f1bf0775fc9ccbf5e63130a1ea217213" "3de5c795291a145452aeb961b1151e63ef1cb9565e3cdbd10521582b5fd02e9a" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(elpaca-wait)

(setq tab-always-indent 'complete)

(setq sentence-end-double-space nil)

(make-directory "~/.config/emacs/backups" t)
(make-directory "~/.config/emacs/autosave" t)
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/autosave" t)))
(setq backup-directory-alist '(("." . "~/.config/emacs/backups")))
(setq backup-by-copying t)

(require 'bind-key)

(defun load-conf ()
  (interactive)
  (find-file "~/.config/emacs/conf.org"))

(bind-key "C-c x" 'load-conf)

;; maybe bind this to something?
(bind-key "C-c n" 'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
