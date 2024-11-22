
(defun sibilant-associate-main ()
  (interactive)
  (setf isend--command-buffer "*sibilant*"))

(defun end-term-input()
  (cond
   ;; Terminal buffer: specifically call `term-send-input'
   ;; to handle both the char and line modes of `ansi-term'.
   ((eq major-mode 'term-mode)
    (term-send-input))

   ;; Other buffer: call whatever is bound to 'RET'
   (t (funcall (key-binding (kbd "RET"))))))

(defun send-sibilant-buffer ()

  (interactive)

  (print "failing harder")

  (let ((b isend--command-buffer)
        (d default-directory))


    (save-excursion

      (set-buffer b)

      (insert (concatenate 'string "(meta (assign sibilant.dir \"" d "\") null)"))

      (insert (concatenate 'string "(add-to-module-lookup\"" d "\")"))
      (insert "\n")
      (end-term-input))

    (isend-send-buffer)

    (save-excursion
      (set-buffer b)
      (insert (concatenate 'string "(meta (assign sibilant.dir  \"./\") null)"))
      (insert "\n")
      (end-term-input))))

(defun send-sibilant-defun ())


(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e a" 'sibilant-associate-main)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e b" 'send-sibilant-buffer)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e f" 'isend-send-defun)
(spacemacs/set-leader-keys-for-major-mode 'sibilant-mode "e i" 'open-sibilant-repl)
