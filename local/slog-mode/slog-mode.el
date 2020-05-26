;; Emacs integration for slog datalog files

;;; Code:

(defvar slog-mode-syntax-table
  (let ((st (make-syntax-table))
	(i 0))
    ;; Symbol constituents
    (while (< i ?0)
      (modify-syntax-entry i "_   " st)
      (setq i (1+ i)))
    (setq i (1+ ?9))
    (while (< i ?A)
      (modify-syntax-entry i "_   " st)
      (setq i (1+ i)))
    (setq i (1+ ?Z))
    (while (< i ?a)
      (modify-syntax-entry i "_   " st)
      (setq i (1+ i)))
    (setq i (1+ ?z))
    (while (< i 128)
      (modify-syntax-entry i "_   " st)
      (setq i (1+ i)))

    ;; Whitespace (except ?\n, see below in comment section)
    (modify-syntax-entry ?\t "    " st)
    (modify-syntax-entry ?\f "    " st)
    (modify-syntax-entry ?\r "    " st)
    (modify-syntax-entry ?\s "    " st)

    ;; These characters are delimiters but otherwise undefined.
    ;; Brackets and braces balance for editing convenience.
    (modify-syntax-entry ?\( "()  " st)
    (modify-syntax-entry ?\) ")(  " st)
    (modify-syntax-entry ?\[ "(]  " st)
    (modify-syntax-entry ?\] ")[  " st)
    (modify-syntax-entry ?{  "(}  " st)
    (modify-syntax-entry ?}  "){  " st)

    ;; Other atom delimiters
    (modify-syntax-entry ?\" "\"   " st)
    (modify-syntax-entry ?'  "'   " st)
    (modify-syntax-entry ?`  "'   " st)
    (modify-syntax-entry ?,  "'   " st)
    (modify-syntax-entry ?@  "'   " st)
    (modify-syntax-entry ?\\ "\\   " st)

    ;; Comment related
    (modify-syntax-entry ?\; "<   " st) ;line comments but NOT sexp #;
    (modify-syntax-entry ?\n ">   " st)

    (modify-syntax-entry ?#  "w 14" st) ;not necessarily prefix
    (modify-syntax-entry ?|  "_ 23bn" st)

    st))

(setq slog-highlights
      '(("?\\|<--\\|-->\\|~\\|\\." . font-lock-keyword-face)
        ("\\number\\|or\\|not\\|=/=\\|=" . font-lock-builtin-face)
        (":" . font-lock-constant-face)))

(define-derived-mode slog-mode fundamental-mode "slog"
  "major mode for editing Slog datalog files."
  :syntax-table slog-mode-syntax-table
  (setq font-lock-defaults '(slog-highlights))
  (setq-local comment-start ";")
  (setq-local comment-end "")
)

(provide 'slog)
