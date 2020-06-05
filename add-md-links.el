;; This is a very rudimentry script to batch process adding links to
;; org files.

;; Use

;; 1. Change the variables
;;    - Limit for links
;;    - Number of notes in the directory
;;    - The path to the directory
;;    - file name extension
;; 2. M-x load-file [this file]
;; 3. Loading will automatically start dolist.
;;    Undo is not considered so careful before
;;    you load this file.

(setq limit-for-links 500)
(setq number-of-notes 10000)
(setq directory "./10000-markdown-files")
(setq file-ext ".org")

(defun generate-link-string()
  "Rondomly choose a note and generate a link string: [[file-name]]."
  (let ((file-name (nth (random number-of-notes)(directory-files directory nil file-ext nil))))
    (concat "[[file:" file-name "]]")))

(defun add-links-n-times-to-file (n file)
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-max))
    (dotimes (i n)
      (insert (concat "\n" (generate-link-string))))
    (insert "\n\n")
    (write-region (point-min) (point-max) file)))

(dolist (path (directory-files directory t file-ext nil))
  (let ((number-of-links (random limit-for-links)))
    (add-links-n-times-to-file number-of-links path)))
