;;; jar-manifest-mode.el -- Major mode to edit JAR manifest files

;;; Copyright (C) 2014 Omair Majid

;; Version: 0.0.1
;; Author: Omair Majid <omair.majid@gmail.com>
;; URL: http://github.com/omajid/jar-manifest-mode
;; Keywords: convenience languages

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see
;; <http://www.gnu.org/licenses/>.

;;; Commentary:

;; TODO
;; - Multiline values
;; - Deal with x-Digest-y and x-Extension-* style attributes
;; - Highlight non-conforming entries as an error

;;; Code:

; FIXME the second should be [:alpha:]
(defconst jar-manifest-header-name-regexp "^[a-zA-Z0-9]\\(?:[a-zA-Z0-9]\\|_\\|-\\)*"
  "Regexp matching a header name.")

(defconst jar-manifest-header-value-regexp " .*$"
  "Regexp matching a header value.")

(defconst jar-manifest-header-regexp
  (concat
   "\\(" jar-manifest-header-name-regexp "\\):"
   "\\(" jar-manifest-header-value-regexp "\\)"))

;; TODO make this more comprehensive
(defconst jar-manifest-known-headers-regexp
  (regexp-opt
   (list "Manifest-Version" "Created-By" "Signature-Version" "Class-Path"
	 "Main-Class"
	 "Extension-List"
	 "Extension-Name"
	 "Implementation-Title" "Implementation-Version" "Implementation-Vendor" "Implementation-Vendor-Id" "Implementation-URL"
	 "Specification-Title" "Specification-Version" "Specification-Vendor"
	 "Sealed"
	 "Content-Type"
	 "Java-Bean"
	 "Magic")))

(defconst jar-manifest-font-lock-keywords
  (list
   (cons jar-manifest-known-headers-regexp 'font-lock-keyword-face)
   (list jar-manifest-header-regexp '(1 font-lock-type-face) '(2 font-lock-string-face)))
  "Expressions to highlight in jar-manifest-mode.")

;;;###autoload
(define-derived-mode jar-manifest-mode prog-mode "Manifest"
  "Major mode for editing JAR Manifest (Manifest.mf) files."

  ;; syntax highlighting
  (setq-local font-lock-defaults '(jar-manifest-font-lock-keywords)))


;;;###autoload
(add-to-list 'auto-mode-alist '("manifest\\.mf\\'" . jar-manifest-mode))

(provide 'jar-manifest-mode)
;;; jar-manifest-mode.el ends here
