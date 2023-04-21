;;; Copyright (c) 2023  Teddy Wing
;;;
;;; This file is part of XFDF.
;;;
;;; XFDF is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; XFDF is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with XFDF. If not, see <https://www.gnu.org/licenses/>.


(in-package :xfdf)

(defun write-xfdf (output-stream fields)
  "Write an XFDF document to `output-stream` using cons cells in the `fields`
list."
  (format output-stream "~
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
")

  (loop for (name . value) in fields
        do
        (format output-stream "~A" (field-xfdf name value)))

  (format output-stream "	</fields>
</xfdf>")

  output-stream)

(defconstant +field-base-indentation+ 2)

(defun field-xfdf (name value)
  "Build an XFDF XML string for a field."
  (field-xfdf* name value 0))

(defun field-xfdf* (name value nesting-level)
  "Build an XFDF XML string for a field. The `nesting-level` specifies the
amount of indentation to use relative to the +field-base-indentation+."
  (let ((indent (+ +field-base-indentation+ nesting-level)))
    (if (consp value)
        (build-xfdf-nested-field name value nesting-level indent)

        (let ((value (pdf-checkbox-value value)))
          (xfdf-field-string name value indent)))))

(defun build-xfdf-nested-field (name value nesting-level indent)
  "Build the XFDF XML for a field containing other fields."
  (let ((inner-fields
          (loop for field in value
                collect
                (let ((subname (if (listp field)
                                   (first field)
                                   field))
                      (subfield (if (listp field)
                                    (rest field)
                                    field)))
                  (field-xfdf* subname subfield (1+ nesting-level))))))
    (xfdf-outer-field-string name inner-fields indent)))

(defun pdf-checkbox-value (value)
  "If `value` is T or NIL, convert it to the default PDF checkbox values
'Yes' and 'Off' respectively.

If `value` is anything else, return its identity."

  (cond ((eq value t) "Yes")
        ((eq value nil) "Off")
        (t value)))

(defun xfdf-outer-field-string (name inner-fields-string indent)
  "Build the XFDF XML string for a field containing other fields."
  (format nil "~
~v{~A~:*~}<field name=\"~A\">
~{~A~}~v{~A~:*~}</field>
"
indent
'("	")
name
inner-fields-string
indent
'("	")))

(defun xfdf-field-string (name value indent)
  "Build the XFDF XML for a single field."
  (format nil "~
~v{~A~:*~}<field name=\"~A\">
~v{~A~:*~}	<value>~A</value>
~v{~A~:*~}</field>
"
indent
'("	")
name
indent
'("	")
value
indent
'("	")))
