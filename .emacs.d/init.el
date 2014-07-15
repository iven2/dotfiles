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
;; I needed these settings so C major mode's control-c control-c will not be in
;; conflict with my comment definition
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

;;; rhtml mode for ruby on rails
;;; rhtml is a html syntax highlighting tool for ruby on rails
(add-to-list 'load-path "~/dotfiles/.emacs.d/plugins/rhtml")
(require 'rhtml-mode)
;; make sure we enable rhtml-mode when the file name ends with erb
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))

;; added to fix ruby indentation problem after type the newline
;; source:
;; http://stackoverflow.com/questions/4412739/emacs-ruby-mode-indentation-behavior
(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))

;;;;;;;;;;;;; adding the php mode
;; source:
;; http://php-mode.sourceforge.net/php-mode.pdf
;; adding load path
(add-to-list 'load-path "~/dotfiles/.emacs.d/modes")
(load '"php-mode")
(add-to-list 'auto-mode-alist '("\\.inc\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))
;;;;;;;; End of adding php mode

;;;;;;;;;;;; auto break long lines
;; source:
;; https://github.com/xiaohanyu/oh-my-emacs/blob/master/core/ome-basic.org
;; http://superuser.com/questions/474373/how-to-automatically-wrap-long-lines-in-emacs
(setq-default fill-column 79)
;; for text text-mode only
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;; for globally, all modes
;; 2014 April 24th update: disable auto-column fill for now since it is
;; annoying sometimes
;; (setq-default auto-fill-function 'do-auto-fill)
;;;;;;;;;;;; end of auto break long lines

;;;;;;;;;;;;;;; adding closure mode
;; source
;; https://github.com/clojure-emacs/clojure-mode
;; load path is already added by php
(load "clojure-mode")
;; omitted the test mode because there is a missing el file , check this out
;; later
;; (load "cloure-mode-test")
;;;;;;;;;;;;;;; end of closure mode

;;;;;;;;;;;; fill-column indicator
;; source:
;; http://www.emacswiki.org/FillColumnIndicator#toc1
;; source name: FillColumnIndicator
(add-to-list 'load-path "~/.emacs.d/plugins/")
(require 'fill-column-indicator)
(setq fci-rule-width 1)
;; (setq fci-rule-color "darkblue")
(setq fci-rule-color "#1E90FF")
;; in emacs 24 or later
;; we can use 'prog-mode-hook to turn on a minor mode in all programming mode
;; (add-hook 'prog-mode-hook #'fci-mode)
;; source:
;; http://stackoverflow.com/questions/12763566/permanently-enabling-the-hs-minor-mode-in-emacs

;; but since this is in conflict with web mode, disable for now and added list
;; of major mode hooks to add this minor mode manually

;; disabled all fci mode on July 11th 2014 because it causes emacs to seg fault
;; (add-hook 'text-mode-hook 'fci-mode)
;; (add-hook 'emacs-lisp-mode-hook 'fci-mode)
;; end of disable on July 11th 2014

;; (add-to-list 'auto-mode-alist '("\\.el\\'" . fci-mode))
;;;;;;;;;;;; end of fill-column indicator

;;;;;;;;;;;;; web mode used for javascript embedded in html ;;;;;;;;;
;; Note that web mode is in conflict with fci-mode
;; I should findo ut why sometimes
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; erb file is better handled with web-mode because rhtml does not indent
;; javascript correctly
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
;;;;;;;;;;;;; End of web mode ;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;; Jade mode for nodejs/express applications ;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/jade-mode")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
;;;;;;;;;;;;;; END of Jade mode for nodejs/express applications ;;;;;;;;;

;;;;;;;;;;;; Smooth scrolling mode ;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/modes/smooth-scrolling")
(require 'smooth-scrolling)
(setq smooth-scroll-margin 1)
;;;;;;;;;;;; End of Smooth scrolling mode ;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;; enter scheme-mode while editing .rkt files ;;;;;;
(setq auto-mode-alist
      (cons '("\\.rkt$" . scheme-mode)
            auto-mode-alist))
;;;;;;;;;;;;;;;;;;;;;;;; End of entering scheme-mode for .rkt files ;;;;;;

;;;;;;;;; Mode for js ;;;
;; js2-mode is the best mode for javascript
(add-to-list 'load-path "~/.emacs.d/modes/js")
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;;;;;;;; end of the Mode for js ;;;

;;;;;;;; auto indent after you hit enter
(electric-indent-mode 1)
;;;;;;;; end of auto indent after you hit enter

;;;;;;; Modification of C comment behaviour ;;;;;;;;;;
;; by default if I wanted to comment a line in C
;; it uses /* ... */
;; the following line modifies it such the comment now uses //
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                        comment-end   "")))
;;;;;;; End of Modification of C comment behaviour ;;;;;;;;;;

;; Start of Testing as of July 15th 2014
;;;; Emacs on Mac OS is deleting backwards, The following line can correct it ;;;;
;;;; Surprisingly this will not emacs in my Linux boxes to mishave
;;;; So I keep this here for testing purpose
(normal-erase-is-backspace-mode 0)
;; End of Testing as of July 15th 2014
