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
  (--each (directory-files boilerplate-path nil "[^.git|README.md]")
    (message it)
    (add-to-list 'available-boilerplate it)))



(defun boilerplate ()
  (interactive)
  (let ((boil (ido-completing-read "Choose boilerplate: " available-boilerplate nil t)))
    (when boil
      (message boil))))

(provide 'emacs-boilerplate)
;;; emacs-boilerplate.el ends here
