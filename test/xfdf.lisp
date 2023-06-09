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


(defpackage :xfdf-test
  (:use :cl
        :1am
        :xfdf))

(in-package :xfdf-test)

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

(test generates-hierarchical-xfdf
  (let ((xfdf-string
          (with-output-to-string (xfdf-stream)
            (xfdf:write-xfdf
              xfdf-stream
              '(("topmostSubform[0]"
                 . (("Page1[0]"
                     . (("c1_01[1]" . "2")
                        ("f1_02[0]" . "Homer J.")
                        ("f1_03[0]" . "Simpson")))
                    ("Page2[0]"
                     . (("f2_02[0]" . "1234")))))
                ("bottommostSubform[0]"
                 . (("Page1[0]"
                     . (("f1_01[0]" . "Annoyed grunt!"))))))))))

    (is (string=
          xfdf-string
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<xfdf xmlns=\"http://ns.adobe.com/xfdf/\" xml:space=\"preserve\">
	<fields>
		<field name=\"topmostSubform[0]\">
			<field name=\"Page1[0]\">
				<field name=\"c1_01[1]\">
					<value>2</value>
				</field>
				<field name=\"f1_02[0]\">
					<value>Homer J.</value>
				</field>
				<field name=\"f1_03[0]\">
					<value>Simpson</value>
				</field>
			</field>
			<field name=\"Page2[0]\">
				<field name=\"f2_02[0]\">
					<value>1234</value>
				</field>
			</field>
		</field>
		<field name=\"bottommostSubform[0]\">
			<field name=\"Page1[0]\">
				<field name=\"f1_01[0]\">
					<value>Annoyed grunt!</value>
				</field>
			</field>
		</field>
	</fields>
</xfdf>"))))
