(defconst db-javascript-packages
  '(
    add-node-modules-path
    flycheck
    prettier-js
    rjsx-mode))

(defun db-javascript/init-rjsx-mode ()
  (use-package rjsx-mode
    :config
    (modify-syntax-entry ?_ "w" js2-mode-syntax-table))

  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

  (setq
    js2-mode-show-strict-warnings nil
    js2-mode-show-parse-errors nil
    js-indent-level 2
    js2-basic-offset 2
    js2-strict-trailing-comma-warning nil
    js2-strict-missing-semi-warning nil)

  (advice-add #'js-jsx-indent-line
              :after
              #'db-javascript/js-jsx-indent-line-align-closing-bracket))

(defun db-javascript/post-init-add-node-modules-path ()
  (add-hook 'rjsx-mode-hook #'add-node-modules-path))

(defun db-javascript/post-init-flycheck ()
  (spacemacs/enable-flycheck 'rjsx-mode))

(defun db-javascript/init-prettier-js ()
  (use-package prettier-js)

  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'web-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode))