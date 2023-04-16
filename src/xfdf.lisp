(in-package :xfdf)

(defun write-xfdf (output-stream fields)
  (format output-stream "~
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
")

  ;; TODO
  ; (loop do)
  (format output-stream "		<field name=\"checkbox-on\">
			<value>Yes</value>
		</field>
		<field name=\"checkbox-off\">
			<value>Off</value>
		</field>
		<field name=\"text\">
			<value>123 Fake Street, Springfield</value>
		</field>
")

  (format output-stream "	</fields>
</xfdf>")

  output-stream)
