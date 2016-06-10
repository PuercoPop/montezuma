(in-package #:asdf-user)


(defsystem #:montezuma-tests
  :description "Tests for Montezuma."
  :depends-on (#:montezuma #:trivial-timeout)
  :components
  ((:module "tests"
     :components
      ((:module "unit"
	  :components ((:file "tests")
		       (:module "util"
			 :components ((:file "tc-priority-queue")
				      (:file "tc-tables")
                                      (:file "strings"))
			 :depends-on ("tests"))
                       (:module "regression"
                                :components ((:file "tc-m2k"))
                         :depends-on ("tests"))
		       (:module "store"
			 :components ((:file "tc-store")
				      (:file "tc-ram-store")
				      (:file "tc-fs-store"))
			 :depends-on ("tests"))
		       (:module "document"
			 :components ((:file "tc-field")
				      (:file "tc-document"))
			 :depends-on ("tests"))
		       (:module "analysis"
			 :components ((:file "tc-lowercase-filter")
				      (:file "tc-stop-filter")
				      (:file "tc-porter-stem-filter")
				      (:file "tc-letter-tokenizer")
				      (:file "tc-whitespace-tokenizer")
				      (:file "tc-lowercase-tokenizer")
				      (:file "tc-standard-tokenizer")
				      (:file "tc-analyzer")
				      (:file "tc-stop-analyzer")
				      (:file "tc-whitespace-analyzer")
				      (:file "tc-standard-analyzer"))
			 :depends-on ("tests"))
                       (:module "search"
                         :components ((:file "tc-similarity")
				      (:file "tc-index-searcher")
				      (:file "tc-boolean-subscorer"))
                         :depends-on ("tests"))
		       (:module "query-parser"
			 :components ((:file "tc-query-parser"))
			 :depends-on ("tests"))
		       (:module "index"
			 :components ((:file "tc-term")
				      (:file "tc-term-info")
				      (:file "tc-term-buffer")
				      (:file "tc-field-infos")
				      (:file "tc-term-infos-io")
				      (:file "tc-term-vectors-io")
				      (:file "tc-fields-io" :depends-on ("th-doc"))
				      (:file "tc-compound-file-io")
				      (:file "tc-segment-term-enum")
				      (:file "tc-segment-term-vector")
				      (:file "tc-segment-infos")
				      (:file "th-doc")
				      (:file "tc-index-writer" :depends-on ("th-doc"))
				      (:file "tc-index-reader" :depends-on ("th-doc"))
				      (:file "tc-multiple-term-doc-pos-enum" :depends-on ("th-doc"))
				      (:file "tc-index"))
			 :depends-on ("tests"))))))))

(defmethod perform ((o test-op) (c (eql (find-system '#:montezuma-tests))))
  (declare (ignore o))
  (or (funcall (intern (symbol-name '#:run-tests)
                       (find-package '#:montezuma)))
      (error "test-op on ~S failed." c)))
