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
             (symbol-call :1am :run)))
