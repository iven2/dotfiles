;; show line numbers
(global-linum-mode t)

;; c++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; don't indent namespace
(c-set-offset 'innamespace 0)

;; ido mode... should read about this
(require 'ido)
(ido-mode t)
;; disable auto-save & backup files
(setq make-backup-files nil)
(setq auto-save-default nil)


;; highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; adds color themes to my emacs
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'spolsky t)

;; define the function to comment or uncomment a line
;; source: http://stackoverflow.com/questions/9688748/emacs-comment-uncomment-current-line
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))

;; bind control-c control-c to comment:)
(global-set-key "\C-c\C-c" 'comment-or-uncomment-region-or-line)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; My key map setting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I needed these settings so C major mode's control-c control-c will not be in conflict with my comment definition
;; I do not understand the reason bedhine these and maybe I should learn about this soon
;; Source: http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs/5340797#5340797
;; Secondary Source:
;; http://stackoverflow.com/questions/12905017/rebinding-keys-in-orgmode
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)

(my-keys-minor-mode 1)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(define-key my-keys-minor-mode-map (kbd "\C-c\C-c") 'comment-or-uncomment-region-or-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; End of my key map setting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; do not use tab for intentation, it may screw up some display in some text editor
(setq-default indent-tabs-mode nil)

;; display column numbers too
(setq column-number-mode t)

;; delete all training white spaces before any save
;; sorce http://www.emacswiki.org/emacs/DeletingWhitespace
 (add-hook 'before-save-hook 'delete-trailing-whitespace)
