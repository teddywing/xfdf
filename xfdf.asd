(asdf:defsystem xfdf
  :description "Convert data to XFDF for PDF forms"
  :version "0.0.1"
  :license "GPL-3.0-or-later"
  :author "Teddy Wing"

  :components ((:module "src"
                :serial t
                :components ((:file "package")
                             (:file "xfdf")))))
