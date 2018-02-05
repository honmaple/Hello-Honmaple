(use-package flycheck
  :ensure t
  :defer t
  :diminish flycheck-mode "ⓢ"
  :init (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (progn
    (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
          flycheck-idle-change-delay 0.8)

    (use-package flycheck-popup-tip
      :ensure t
      :defer t
      :init (add-hook 'after-init-hook #'flycheck-popup-tip-mode)
      :config
      (setq flycheck-display-errors-function #'flycheck-popup-tip-error-messages))

    (when (and (fboundp 'define-fringe-bitmap))
      (define-fringe-bitmap 'maple-flycheck-fringe-indicator
        (vector #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00011100
                #b00111110
                #b00111110
                #b00111110
                #b00011100
                #b00000000
                #b00000000
                #b00000000
                #b00000000
                #b00000000)))

    (let ((bitmap 'maple-flycheck-fringe-indicator))
      (flycheck-define-error-level 'error
        :severity 2
        :overlay-category 'flycheck-error-overlay
        :fringe-bitmap bitmap
        :fringe-face 'flycheck-fringe-error)
      (flycheck-define-error-level 'warning
        :severity 1
        :overlay-category 'flycheck-warning-overlay
        :fringe-bitmap bitmap
        :fringe-face 'flycheck-fringe-warning)
      (flycheck-define-error-level 'info
        :severity 0
        :overlay-category 'flycheck-info-overlay
        :fringe-bitmap bitmap
        :fringe-face 'flycheck-fringe-info))
    (defun maple/toggle-flycheck-error-list ()
      "Toggle flycheck's error list window.
    If the error list is visible, hide it.  Otherwise, show it."
      (interactive)
      (-if-let (window (flycheck-get-error-list-window))
          (quit-window nil window)
        (flycheck-list-errors))))
  :evil-bind
  (normal flycheck-error-list-mode-map
          "q" 'quit-window
          "j" #'flycheck-error-list-next-error
          "k" #'flycheck-error-list-previous-error
          "K" #'evil-previous-line
          "J" #'evil-next-line
          (kbd "RET") #'flycheck-error-list-goto-error))


;; 显示tooltip
;; (use-package flycheck-pos-tip
;;   :ensure t
;;   :after flycheck
;;   :defer t )


(provide 'init-flycheck)
