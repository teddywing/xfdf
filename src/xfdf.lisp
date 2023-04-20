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

(defun field-xfdf (name value)
  (field-xfdf* name value 0))

(defun field-xfdf* (name value nesting-level)
  ""
  (let ((indent (+ 2 nesting-level)))
    ;; TODO: Add checkbox default values.
    (format t "debug1: n'~A' : v'~A' : n'~A'~%" name value nesting-level)
    (if (listp value)
        ;; TODO: We need to do something with value
        ;; TODO: How to concat results from dolist?
        (format nil "~{~A~}"
         (loop for field in value
               collect
               (let ((subname (if (listp field)
                                  (first field)
                                  field))
                     (subfield (if (listp field)
                                   (rest field)
                                   field)))
                 (field-xfdf* subname subfield (1+ nesting-level)))))

        ;; TODO: Put checkbox stuff here.
        (let ((value (cond ((eq value t) "Yes")
                           ((eq value nil) "Off")
                           (t value))))
          (format t "debug2: n'~A' : v'~A' : n'~A'~%" name value nesting-level)
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
'("	"))))))
;; * (format t "~v{~A~:*~}<>~A" 5 '("Hello") "Next")
