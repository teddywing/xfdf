(in-package :xfdf)

(defun write-xfdf (output-stream fields)
  "Write an XFDF document to `output-stream` using cons cells in the `fields`
list."
  (format output-stream "~
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
")

;   (loop for (name . value) in fields
;         do
;         (let ((value (cond ((eq value t) "Yes")
;                            ((eq value nil) "Off")
;                            (t value))))
;           (format output-stream "		<field name=\"~A\">
; 			<value>~A</value>
; 		</field>
; "
; name
; value)))

  (loop for (name . value) in fields
        do
        (format output-stream "~A" (field-xfdf name value)))

  (format output-stream "	</fields>
</xfdf>")

  output-stream)

(defconstant +field-base-indentation+ 2)

(defun field-xfdf (name value)
  (field-xfdf* name value 0))

(defun field-xfdf* (name value nesting-level)
  ""
  (let ((indent (+ +field-base-indentation+ nesting-level)))
    ;; TODO: Add checkbox default values.
    (if (consp value)
        ;; TODO: We need to do something with value
        ;; TODO: How to concat results from dolist?
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
          (format nil "~
~v{~A~:*~}<field name=\"~A\">
~{~A~}~v{~A~:*~}</field>
"
indent
'("	")
name
inner-fields
indent
'("	")))

        ;; TODO: Put checkbox stuff here.
        (let ((value (pdf-checkbox-value value)))
          (build-xfdf-field name value indent)))))
;; * (format t "~v{~A~:*~}<>~A" 5 '("Hello") "Next")

(defun pdf-checkbox-value (value)
  "If `value` is T or NIL, convert it to the default PDF checkbox values
'Yes' and 'Off' respectively.

If `value` is anything else, return its identity."

  (cond ((eq value t) "Yes")
        ((eq value nil) "Off")
        (t value)))

(defun build-xfdf-field (name value indent)
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
