(require 'dash)
(require 's)

(defvar available-boilerplate nil
  "The list of available boilerplate.")

(defvar boilerplate-path (expand-file-name "boilerplate"
                                           user-emacs-directory)
  "The directory where boilerplate should be created.")

(defvar boil-output "*boilerplate-output*"
  "Name of the buffer where output from the running process is displayed.")


(defun touch-boilerplate ()
  (interactive)
  (let ((name (completing-read "Boilerplate: " (-map 'car available-boilerplate) nil)))
    (call-interactively (cdr (assoc name)))))


(when (file-exists-p boilerplate-path)
  (--each (directory-files boilerplate-path nil nil)
    (add-to-list 'available-boilerplate it)))


(defun boilerplate ()
  (interactive)
  (let ((boil (ido-completing-read "Choose boilerplate: " available-boilerplate nil t)))
    (when boil
      (copy-boilerplate-directory boil))))

(defun check-file-or-dir (boil)
  (file-directory-p))

(defun copy-boilerplate-directory (boil)
  (let ((name (read-from-minibuffer "New Name: " boil)))
    (copy-directory (expand-file-name boilerplate-path boil)
                    (concat
                     (file-name-directory
                      (or load-file-name buffer-file-name)) name))))


(--each (-remove (lambda (boil) (or (s-equals? ".git" boil) (s-equals? "README.md" boil)))
                 (directory-files boilerplate-path nil nil))
  (message it))

(provide 'emacs-boilerplate)
;;; emacs-boilerplate.el ends here
