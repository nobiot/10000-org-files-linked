;; Use

;; 1. Change the variables
;;    - Limit for links
;;    - Number of notes in the directory
;;    - The path to the directory
;; 2. M-x load-file [this file]
;; 3. Loading will automatically start dolist!
;;    so careful before you do so.

;; For each note, rendomly pick n
;; Repeat n times for a file
;; Randomly pick a note from N
;; Add links to m notes to a file

(setq limit-for-links 10)
(setq number-of-notes 100)
(setq directory "./100-markdown-files")
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

(dolist (path (directory-files "./100-markdown-files" t file-ext nil))
  (let ((number-of-links (random limit-for-links)))
    (add-links-n-times-to-file number-of-links path)))
