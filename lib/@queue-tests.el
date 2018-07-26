;;; -*- lexical-binding: t; -*-

(require 'ert)
(require 'cl-lib)
(require '@stack)
(require '@queue)

(ert-deftest @queue-test ()
  (let ((q (@! @queue :new)))
    (@! q :enqueue 0)
    (@! q :enqueue 1)
    (@! q :dequeue)
    (@! q :enqueue 2)
    (@! q :enqueue 3)
    (should (= 3 (@! q :size)))
    (should
     (equal '(1 2 3)
            (cl-loop until (@! q :emptyp) collect (@! q :dequeue))))
    (should (= 0 (@! q :size)))))

(ert-deftest @queue-stack ()
  (let ((q (@extend @queue @stack)))
    (@! q :enqueue 'b)
    (should (eq 'b (@! q :peek)))
    (@! q :enqueue 'c)
    (@! q :push 'a)
    (should (= 3 (@! q :size)))
    (should
     (equal '(a b c)
            (@! q :to-list)))))
