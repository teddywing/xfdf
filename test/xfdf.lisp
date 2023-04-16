(defpackage :xfdf-test
  (:use :cl
        :1am
        :xfdf)

  ; (:export #:run)
  )

(in-package :xfdf-test)

; (defun run ()
;   (1am:run))

(test generates-xfdf-xml
  (let ((xfdf-string
          (with-output-to-string (xfdf-stream)
            (xfdf:write-xfdf
              xfdf-stream
              '(("checkbox-on" . t)
                ("checkbox-off" . nil)
                ("text" . "123 Fake Street, Springfield"))))))
    (is (string=
          xfdf-string
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
		<field name=\"checkbox-on\">
			<value>Yes</value>
		</field>
		<field name=\"checkbox-off\">
			<value>Off</value>
		</field>
		<field name=\"text\">
			<value>123 Fake Street, Springfield</value>
		</field>
	</fields>
</xfdf>"))))
