(defvar elpaca-installer-version 0.6)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))
;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq elpaca-use-package-by-default t))

(use-package org
  :ensure t)

;; Block until current queue processed.
(elpaca-wait)

(org-babel-load-file
  (expand-file-name "conf.org"
    user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
    '("f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "9d29a302302cce971d988eb51bd17c1d2be6cd68305710446f658958c0640f68" "b9761a2e568bee658e0ff723dd620d844172943eb5ec4053e2b199c59e0bcc22" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "38c0c668d8ac3841cb9608522ca116067177c92feeabc6f002a27249976d7434" "3fe1ebb870cc8a28e69763dde7b08c0f6b7e71cc310ffc3394622e5df6e4f0da" "162201cf5b5899938cfaec99c8cb35a2f1bf0775fc9ccbf5e63130a1ea217213" "3de5c795291a145452aeb961b1151e63ef1cb9565e3cdbd10521582b5fd02e9a" default))
 '(jka-compr-compression-info-list
    '(["\\.Z\\'" "compressing" "compress"
        ("-c")
        "uncompressing" "gzip"
        ("-c" "-q" "-d")
        nil t "\37\235" zlib-decompress-region]
       ["\\.bz2\\'" "bzip2ing" "bzip2" nil "bunzip2ing" "bzip2"
         ("-d")
         nil t "BZh" nil]
       ["\\.tbz2?\\'" "bzip2ing" "bzip2" nil "bunzip2ing" "bzip2"
         ("-d")
         nil nil "BZh" nil]
       ["\\.\\(?:tgz\\|svgz\\|sifz\\)\\'" "compressing" "gzip"
         ("-c" "-q")
         "uncompressing" "gzip"
         ("-c" "-q" "-d")
         t nil "\37\213" zlib-decompress-region]
       ["\\[^\\.z].z\\'" "compressing" "gzip"
         ("-c" "-q")
         "uncompressing" "gzip"
         ("-c" "-q" "-d")
         t t "\37\213" zlib-decompress-region]
       ["\\.gz\\'" "compressing" "gzip"
         ("-c" "-q")
         "uncompressing" "gzip"
         ("-c" "-q" "-d")
         t t "\37\213" zlib-decompress-region]
       ["\\.lz\\'" "Lzip compressing" "lzip"
         ("-c" "-q")
         "Lzip uncompressing" "lzip"
         ("-c" "-q" "-d")
         t t "LZIP" nil]
       ["\\.lzma\\'" "LZMA compressing" "lzma"
         ("-c" "-q" "-z")
         "LZMA uncompressing" "lzma"
         ("-c" "-q" "-d")
         t t "" nil]
       ["\\.xz\\'" "XZ compressing" "xz"
         ("-c" "-q")
         "XZ uncompressing" "xz"
         ("-c" "-q" "-d")
         t t "\3757zXZ\0" nil]
       ["\\.txz\\'" "XZ compressing" "xz"
         ("-c" "-q")
         "XZ uncompressing" "xz"
         ("-c" "-q" "-d")
         t nil "\3757zXZ\0" nil]
       ["\\.dz\\'" nil nil nil "uncompressing" "gzip"
         ("-c" "-q" "-d")
         nil t "\37\213" nil]
       ["\\.zst\\'" "zstd compressing" "zstd"
         ("-c" "-q")
         "zstd uncompressing" "zstd"
         ("-c" "-q" "-d")
         t t "(\265/\375" nil]
       ["\\.tzst\\'" "zstd compressing" "zstd"
         ("-c" "-q")
         "zstd uncompressing" "zstd"
         ("-c" "-q" "-d")
         t nil "(\265/\375" nil]))
 '(org-link-frame-setup
    '((vm . vm-visit-folder-other-frame)
       (vm-imap . vm-visit-imap-folder-other-frame)
       (gnus . org-gnus-no-new-news)
       (file . find-file)
       (wl . wl-other-frame)))
 '(package-selected-packages
    '(editorconfig sudo-edit ag which-key doom-themes doom-modeline nerd-icons rainbow-delimiters rainbow-mode all-the-icons lsp-haskell lsp-mode haskell-mode lua-mode evil-org evil-surround evil-collection))
 '(tab-always-indent 'complete)
 '(tab-first-completion nil)
 '(tab-stop-list '(2 4))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
