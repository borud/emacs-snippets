;;;
;;; Snippet shortcuts
;;;
;;; This is a very quick and dirty hack for managing my snippets.
;;; Snippets, in this context, are short notes to keep track of what I
;;; am doing and what I should be doing.
;;;
;;; I use Markdown to format my snippets.
;;;
;;; Put this file somewhere in your emacs load path and add this to
;;; your .emacs file:
;;;
;;;   (require 'snippets)
;;;   (global-set-key (kbd "C-c S") 'snippet-visit-file)
;;;
;;; <borud@borud.org>
;;;
(defvar snippet-root-directory "~/Dropbox/log/snippets/")

(defun snippet-make-directory-name ()
  "Generate directory name for snippet dir"
  (concat (expand-file-name snippet-root-directory) (format-time-string "%Y/%m")))

(defun snippet-make-filename ()
  "Make snippet filename for today"
  (concat (snippet-make-directory-name) (format-time-string "/week-%W.md")))

(defun snippet-visit-file ()
  "Find and visit the snippet file for today"
  (interactive)
  (let ((dir (snippet-make-directory-name))
	(file (snippet-make-filename)))

    ;; let the user know we are working
    (message (concat "Opening " file "..."))

    ;; make directory if it does not exist
    (or (file-directory-p dir)
	(progn
	  (make-directory dir t)
	  ;; 493 == 0755
	  (set-file-modes dir 493)))

    ;; invariant: dir exists
    (find-file file)

    ;; Save it if new
    (or (file-exists-p file)
	(progn
	  (snippet-insert-header-at-point)
	  (snippet-append-timestamp-header)
	  (save-buffer)
	  ;; 420 == 0644
	  (set-file-modes file 420)))

    ;; Set local keybinding
    (local-set-key (kbd "C-c a") 'snippet-append-timestamp-header)
    
    (goto-char (point-max))))

(defun snippet-insert-header-at-point ()
  (interactive)
  (insert
   (concat "# Snippets for week " (format-time-string "%W") "\n\n"
	   "## Goals\n\n"
	   "## Later\n\n"
	   "## Work log\n")))

(defun snippet-append-timestamp-header ()
  (interactive)
  (goto-char (point-max))
  (insert (concat "\n" (format-time-string "### %Y-%m-%d") "\n  - ")))

(provide 'snippets)
