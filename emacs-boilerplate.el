;;; emacs-boilerplate.el --- a emacs package use for add project-archetypes to current directory!

;; Copyright (C) 2015 Aby Chan  <abchan@outlook.com>

;; Author: Aby Chan <abychan@outlook.com>
;; Version: 0.1
;; URL: https://github.com/Emacs-Phoenix/emacs-boilerplate

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; For more information, See URL https://github.com/Emacs-Phoenix/emacs-boilerplate.

;;; Commentary:
;;nil now

;;; Code:


(require 'dash)
(require 's)

(defvar boilerplate-dir "boilerplate")

(defvar available-boilerplate nil
  "The list of available boilerplate.")

(defvar boilerplate-path (expand-file-name boilerplate-dir
                                           user-emacs-directory)
  "The directory where boilerplate should be created.")

(defvar boil-output "*boilerplate-output*"
  "Name of the buffer where output from the running process is displayed.")



(defun boilerplate ()
  "Main programming for add boilerplate."
  (interactive)
  (let ((boil (ido-completing-read "Choose boilerplate: " available-boilerplate nil t)))
    (when boil
      (if (check-is-dir boil)
          (copy-boilerplate-directory boil)
        (copy-boilerplate-file boil)))))

(defun check-is-dir (boil)
  "Check `boil' BOIL is dir or file."
  (file-directory-p (expand-file-name boil boilerplate-path)))

(defun copy-boilerplate-file (boil)
  "Copy `boil'BOIL(file)."
  (if (y-or-n-p (concat "Copy \"" boil "\"?"))
      (copy-file (expand-file-name boil boilerplate-path)
                 (expand-file-name boil (file-name-directory
                                         (or load-file-name buffer-file-name))))))


(defun copy-boilerplate-directory (boil)
  "Copy `boil'BOIL(directory)."
  (let ((name (read-from-minibuffer "New Name: " boil)))
    (copy-directory (expand-file-name boil boilerplate-path)
                    (concat
                     (file-name-directory
                      (or load-file-name buffer-file-name))
                     name))))


(when (file-exists-p boilerplate-path)
  (--each (-remove (lambda (boil) (or (s-equals? ".git" boil)
                                      (s-equals? "README.md" boil)
                                      (s-equals? ".tern-port" boil)
                                      (s-equals? "." boil)
                                      (s-equals? ".." boil)))
                   (directory-files boilerplate-path nil nil))
    (add-to-list 'available-boilerplate it)))


(provide 'emacs-boilerplate)
;;; emacs-boilerplate.el ends here
