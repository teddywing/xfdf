(in-package :xfdf)

(defun write-xfdf (output-stream fields)
  (format output-stream "~
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
")

  (loop for (name . value) in fields
        do
        (let ((value (cond ((eq value t) "Yes")
                           ((eq value nil) "Off")
                           (t value))))
          (format output-stream "		<field name=\"~A\">
			<value>~A</value>
		</field>
"
name
value)))

  (format output-stream "	</fields>
</xfdf>")

  output-stream)
