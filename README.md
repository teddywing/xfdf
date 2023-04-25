xfdf
====

A library to generate XFDF XML to fill in interactive PDF form fields.


## Example
This code:

``` common-lisp
;;; xfdf-example.lisp

(ql:quickload "xfdf")

(format t "~A"
        (with-output-to-string (xfdf-stream)
          (xfdf:write-xfdf
            xfdf-stream
            '(("topmostSubform[0]"
               . (("Page1[0]"
                   . (("c1_01[1]" . "2")
                      ("f1_02[0]" . "Homer J.")
                      ("f1_03[0]" . "Simpson")
                      ("f1_05[0]" . "Marjorie J.")
                      ("f1_06[0]" . "Simpson")
                      ("Address[0]"
                       . (("f1_08[0]" . "742 Evergreen Terrace")
                          ("f1_10[0]" . "Springfield")))))
                  ("Page2[0]"
                   . (("f2_33[0]" . "Nuclear safety inspector")))))))))
```

produces the following XML:

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
	<fields>
		<field name="topmostSubform[0]">
			<field name="Page1[0]">
				<field name="c1_01[1]">
					<value>2</value>
				</field>
				<field name="f1_02[0]">
					<value>Homer J.</value>
				</field>
				<field name="f1_03[0]">
					<value>Simpson</value>
				</field>
				<field name="f1_05[0]">
					<value>Marjorie J.</value>
				</field>
				<field name="f1_06[0]">
					<value>Simpson</value>
				</field>
				<field name="Address[0]">
					<field name="f1_08[0]">
						<value>742 Evergreen Terrace</value>
					</field>
					<field name="f1_10[0]">
						<value>Springfield</value>
					</field>
				</field>
			</field>
			<field name="Page2[0]">
				<field name="f2_33[0]">
					<value>Nuclear safety inspector</value>
				</field>
			</field>
		</field>
	</fields>
</xfdf>
```


## Resources

[XFDF reference](https://web.archive.org/web/20180730100811/https://www.immagic.com/eLibrary/ARCHIVES/TECH/ADOBE/A070914X.pdf)
