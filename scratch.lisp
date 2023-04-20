(ql:quickload "xfdf-test")
(1am:run)
(consp '(1 2 3 4))

(xfdf::field-xfdf* "name" '(("value" . "1") ("v2" . "2")) 0)
