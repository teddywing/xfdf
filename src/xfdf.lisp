(in-package :xfdf)

(defun write-xfdf (output-stream fields)
  (format output-stream "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
")

  ;; TODO
  ; (loop do)

  (format output-stream "	</fields>
</xfdf>"))
