(defun sibilant-associate-main ()
  (interactive)
  (setf isend--command-buffer "*sibilant*"))

(defun end-term-input()
  (cond
   ;; Terminal buffer: specifically call `term-send-input'
   ;; to handle both the char and line modes of `ansi-term'.
   ((eq major-mode 'term-mode)
    (print "term mode detected")
    (term-send-input))

   ;; Other buffer: call whatever is bound to 'RET'
   (t (print "not term mode detected")
      (funcall (key-binding (kbd "RET"))))))

(defun send-sibilant-buffer ()

  (interactive)

  (let ((b isend--command-buffer)
        (d default-directory)
        (cb (current-buffer)))


    (print d)
    (let ((prefix-sibilant-dir (concat   "(meta (assign sibilant.dir \"" d "\") null)"))
          (prefix-sibilant-add-to-lookup (concat   "(add-to-module-lookup\"" d "\")"))
          (postfix-sibilant-reset-dir (concat   "(meta (assign sibilant.dir  \"./\") null)")))



      (save-excursion

        (set-buffer b)
        (print prefix-sibilant-dir)
        (insert prefix-sibilant-dir)
        (insert "\n")

        (print prefix-sibilant-add-to-lookup)
        (insert prefix-sibilant-add-to-lookup)
        (insert "\n")

        )
      (save-excursion


        (print "sending buffer")
        (set-buffer b)
        (insert-buffer cb)
        (insert "\n")

        )
      (save-excursion

        (set-buffer b)

        (print "sending post processing to clean up dependency lookup")
        (print  postfix-sibilant-reset-dir)
        (insert postfix-sibilant-reset-dir)

        (insert "\n")

        (print (end-term-input))
        ;; (insert (end-term-input))

        (insert "\n")))))

(defun send-sibilant-defun ())


(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e a" 'sibilant-associate-main)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e b" 'send-sibilant-buffer)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e f" 'isend-send-defun)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e i" 'open-sibilant-repl)
