(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

 ;; fix emacs repos being really dumb
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor-type 'hbar)
 '(package-selected-packages '(evil-visual-mark-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)

(setq evil-default-cursor 'hbar)
(setq-default cursor-type 'hbar)
(setq-default cursor-in-non-selected-windows 'hollow)


(defun display-startup-echo-area-message ()
  (message "oh no he's evil now"))

(setq initial-scratch-message ";; oh look this is how you set this!
")

(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

;; don't follow symlinks to their real locations
(setq vc-follow-symlinks nil)

(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode t)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t)


