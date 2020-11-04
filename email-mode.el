;;; email-mode.el --- An email composition mode                       -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Olav Fosse

;; Author: Olav Fosse <mail@olavfosse.no>
;; Version: 0.1
;; URL: https://github.com/olav35/email-mode
;; Package-Requires: ((emacs "24.1"))

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

;;; Commentary:

;; An email composition mode

;;; Code:
(defun email-mode-line-quoted-p ()
  "Return t if line is quoted, and nil otherwise"
  (save-excursion
    (move-beginning-of-line nil)
    (when (string-equal (string (following-char)) ">")
      (forward-char)
      (string-equal (string (following-char)) " "))))

(defun email-mode-quote ()
  "Add one level of quotation to the current line"
  (interactive)
  (save-excursion
    (move-beginning-of-line nil)
    (insert "> ")))

(defun email-mode-unquote ()
  "Remove one level of quoatation from the current line"
  (interactive)
  (save-excursion
    (when email-mode-line-quoted-p
	(delete-char 2))))

(defvar email-mode-map nil)
(setq email-mode-map (make-sparse-keymap))

(define-key email-mode-map (kbd "C-c C-q") 'email-mode-quote)
(define-key email-mode-map (kbd "C-c C-u") 'email-mode-unquote)

(define-derived-mode email-mode text-mode "Email"
  (setq-local comment-dwim 'email-mode-quote))

;;; email-mode.el ends here
