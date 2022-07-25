;; -*- coding: utf-8 -*-

(require 'cl)
(require 'hydra)
(require 'vterm)
(require 'flycheck)
(require 'lsp-mode)
(require 'lsp-javascript)

;;; gcc-bazel-init common command
;;; /b/{

(defvar gcc-bazel-init/build-buffer-name
  "*gcc-bazel-init-build*")

(defun gcc-bazel-init/lint ()
  (interactive)
  (rh-project-compile
   "yarn-run app:lint"
   gcc-bazel-init/build-buffer-name))

(defun gcc-bazel-init/build ()
  (interactive)
  (rh-project-compile
   "yarn-run app:build"
   gcc-bazel-init/build-buffer-name))

(defun gcc-bazel-init/clean ()
  (interactive)
  (rh-project-compile
   "yarn-run app:clean"
   gcc-bazel-init/build-buffer-name))

;;; /b/}

;;; gcc-bazel-init
;;; /b/{

(defun gcc-bazel-init/hydra-define ()
  (defhydra gcc-bazel-init-hydra (:color blue :columns 5)
    "@gcc-bazel-init workspace commands"
    ("l" gcc-bazel-init/lint "lint")
    ("b" gcc-bazel-init/build "build")
    ("c" gcc-bazel-init/clean "clean")))

(gcc-bazel-init/hydra-define)

(define-minor-mode gcc-bazel-init-mode
  "gcc-bazel-init project-specific minor mode."
  :lighter " gcc-bazel-init"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<f9>") #'gcc-bazel-init-hydra/body)
            map))

(add-to-list 'rm-blacklist " gcc-bazel-init")

(defun gcc-bazel-init/lsp-deps-providers-path (path)
  (concat (expand-file-name (rh-project-get-root))
          "node_modules/.bin/"
          path))

(defun gcc-bazel-init/config-lsp-javascript ()
  (plist-put
   lsp-deps-providers
   :local (list :path #'gcc-bazel-init/lsp-deps-providers-path))

  (lsp-dependency 'typescript-language-server
                  '(:local "typescript-language-server"))

  (lsp--require-packages)

  (lsp-dependency 'typescript '(:local "tsserver"))

  (add-hook
   'lsp-after-initialize-hook
   #'gcc-bazel-init/flycheck-add-eslint-next-to-lsp))

(defun gcc-bazel-init/flycheck-add-eslint-next-to-lsp ()
  (when (seq-contains-p '(js2-mode typescript-mode web-mode) major-mode)
    (flycheck-add-next-checker 'lsp 'javascript-eslint)))

(defun gcc-bazel-init/flycheck-after-syntax-check-hook-once ()
  (remove-hook
   'flycheck-after-syntax-check-hook
   #'gcc-bazel-init/flycheck-after-syntax-check-hook-once
   t)
  (flycheck-buffer))

;; (eval-after-load 'lsp-javascript #'gcc-bazel-init/config-lsp-javascript)
(eval-after-load 'lsp-mode #'gcc-bazel-init/config-lsp-javascript)

(defun gcc-bazel-init-setup ()
  (when buffer-file-name
    (let ((project-root (rh-project-get-root))
          file-rpath ext-js)
      (when project-root
        (setq file-rpath (expand-file-name buffer-file-name project-root))
        (cond
         ;; This is required as tsserver does not work with files in archives
         ((bound-and-true-p archive-subfile-mode)
          (company-mode 1))

         ((or (setq
               ext-js
               (string-match-p "\\.ts\\'\\|\\.tsx\\'\\|\\.js\\'\\|\\.jsx\\'"
                               file-rpath))
              (string-match-p "^#!.*node"
                              (or (save-excursion
                                    (goto-char (point-min))
                                    (thing-at-point 'line t))
                                  "")))

          (when (boundp 'rh-js2-additional-externs)
            (setq-local rh-js2-additional-externs
                        (append rh-js2-additional-externs
                                '("require" "exports" "module" "process"
                                  "__dirname"))))

          (setq-local flycheck-idle-change-delay 3)
          (setq-local flycheck-check-syntax-automatically
                      ;; '(save mode-enabled)
                      '(save idle-change mode-enabled))
          (setq-local flycheck-javascript-eslint-executable
                      (concat (expand-file-name project-root)
                              "node_modules/.bin/eslint"))

          (setq-local lsp-enabled-clients '(ts-ls))
          ;; (setq-local lsp-headerline-breadcrumb-enable nil)
          (setq-local lsp-before-save-edits nil)
          (setq-local lsp-modeline-diagnostics-enable nil)
          (add-hook
           'flycheck-after-syntax-check-hook
           #'gcc-bazel-init/flycheck-after-syntax-check-hook-once
           nil t)
          (lsp)
          ;; (lsp-headerline-breadcrumb-mode -1)

          (prettier-mode 1)))))))

;;; /b/}
