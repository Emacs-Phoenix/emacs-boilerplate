(require 'dash)
(require 's)

(defvar available-boilerplate nil
  "The list of available boilerplate.")

(defvar boilerplate-path (expand-file-name "boilerplate"
                                           user-emacs-directory)
  "The directory where boilerplate should be created.")

(defvar boil-output "*boilerplate-output*"
  "Name of the buffer where output from the running process is displayed.")


(defun declare-boilerplate (name fn)
  "Add boilerplate to the list of available ones"
  (add-to-list 'available-boilerplate (cons name fn)))

(defun touch-boilerplate ()
  (interactive)
  (message available-boilerplate)
  (let ((name (completing-read "Boilerplate: " (-map 'car available-boilerplate) nil)))
    (call-interactively (cdr (assoc name)))))


(when (file-exists-p pa-folder)
  (--each (directory-files pa-folder nil "^[^#].*el$")
    (load (expand-file-name it pa-folder))))



(provide 'emacs-boilerplate)
;;; emacs-boilerplate.el ends here
