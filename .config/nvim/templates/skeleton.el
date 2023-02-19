#!/usr/bin/emacs --script

(message "Hello world!  I'm writing to STDERR.")
(princ "Hello world!  I'm writing to STDOUT but ")
(princ "I'm not in quotes!")
(print "Hello world!  I'm writing to STDOUT but I'm in quotes")
(princ (format "Hello, %s!\n" "World"))

;; (insert "Hello world!  I'm writing to an Emacs buffer")
;; ;; Save the buffer you just wrote to.
;; (write-file "y.txt")
