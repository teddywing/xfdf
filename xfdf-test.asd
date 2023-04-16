(asdf:defsystem xfdf-test
  :description "Test suite for xfdf"
  :version "0.0.1"
  :license "GPL-3.0-or-later"
  :author "Teddy Wing"

  :depends-on (:1am
               :xfdf)

  :components ((:module "test"
                :serial t
                :components ((:file "xfdf"))))

  :perform (test-op
             (op system)
             ; (symbol-call :xfdf-test :run)
             (symbol-call :1am :run)))
