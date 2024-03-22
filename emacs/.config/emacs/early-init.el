;;; early-init.el --- Initialization file for Emacs
;;; Commentary:
;;; Emacs Startup File --- initialization for Emacs
;;; Code:

(setq package-enable-at-startup nil)

;; disable some graphical junk
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

(setq inhibit-startup-screen t
  frame-resize-pixelwise t)

(setq-default cursor-type 'hbar)
(setq-default cursor-in-non-selected-windows 'hollow)

(provide 'early-init)
;;; early-init.el ends here
