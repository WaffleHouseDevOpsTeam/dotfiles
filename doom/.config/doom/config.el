;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.

;; :Ex is too powerful
(defun +ex-open-dired ()
  "Open dired like :Ex in Vim."
  (interactive)
  (dired default-directory))

(evil-ex-define-cmd "Ex" #'+ex-open-dired)

(setq user-full-name "Daniel Blue"
      user-mail-address "danielhunterblue@gmail.com")
;; tabs (or lack thereof) and spaces configuration
;; (setq-default indent-tabs-mode nil)
;;(setq-default tab-width 4)
;; sets the emacs window to be a good size :)
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 90))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
         (cons 'height (/ (- (x-display-pixel-height) 220)
                             (frame-char-height)))))))
(setq menu-bar-mode 1)
(set-frame-size-according-to-resolution)
;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
(setq doom-font
      (font-spec :family "LigaSFMonoNerdFont"  ;; exact family name as reported by `fc-list`
                 :size   14                         ;; pick a size you like
                 :weight 'regular))                ;; or 'semi-light, 'bold, etc.

;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

(after! doom-themes
  (custom-set-faces!
    '(default :background "#000000")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(after! org-transclusion
  (setq org-transclusion-allow-edit t))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory '("~/Documents/college/", "~/Documents/reflections"))
(setq org-agenda-files
      (append
       (directory-files-recursively "~/Documents/college/Fall2025/" "\\.org$")
       (directory-files-recursively "~/Documents/" "\\.org$")))
(setq org-roam-directory (file-truename "~/Documents/college/Fall2025/"))
(setq org-roam-file-extensions '("org"))
(setq org-use-property-inheritance t)
(setq org-hide-macro-markers t)
(setq global-auto-revert-mode 1)

(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
     (eshell-term . t)
     (C . t)
     (latex . t)
     (lua . t)
     (rust . t)
     (gnuplot . t)
     (jupyter . t)
     (octave . t))))
(after! evil-numbers
        (define-key evil-normal-state-map (kbd "g a") 'evil-numbers/inc-at-pt)
        (define-key evil-normal-state-map (kbd "g x") 'evil-numbers/dec-at-pt))

(use-package! org-download
  :after org
  :config
  (setq org-download-method 'directory
        org-download-image-dir "~/Documents/college/images"
        org-download-heading-lvl nil
        org-download-screenshot-method "flameshot gui")
  (add-hook 'dired-mode-hook 'org-download-enable))

(use-package! evil-numbers)

(use-package! gptel
 :config
 (setq! gptel-api-key (getenv "GPTEL_API_KEY")))

(use-package! typst-mode
    :mode ("\\.typ\\'" . typst-mode))

(use-package! org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package! org-roam-ui
  :after org-roam
  :hook (org-roam-mode . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package! pdf-tools)

(use-package! org-transclusion
  :after org
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

(use-package! org-noter
  :after pdf-tools
  :config
  (setq org-noter-notes-search-path '("~/Documents/college")))

(use-package! vterm
  :ensure t
  :commands vterm)

(use-package! jupyter
  :after org
  :config
  (require 'jupyter))

;;(use-package! octave)
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
(load! "binds.el")
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun my/gptel-send-region-or-buffer ()
  "Send region or buffer to GPTel."
  (interactive)
  (let ((text (if (use-region-p)
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (buffer-string))))
    (gptel-send text)))

(defun my/gptel-query-org-directory ()
  "Ask GPTel a question using all files in `org-directory`."
  (interactive)
  (let* ((files (directory-files-recursively org-directory "\\.org$"))
         (context (mapconcat #'my/org-file->text files "\n\n"))
         (query (read-string "Ask your notes: "))
         (prompt (format "Using the following notes, answer this: %s\n\n%s" query context)))
    (gptel-send prompt)))

(defun my/org-file->text (file)
  (with-temp-buffer
    (insert-file-contents file)
    (org-mode)
    (org-export-as 'plain t t)))
