(define (append-reverse hs ts)
  (or (and (null? hs) ts)
      (append-reverse (cdr hs) (cons (car hs) ts))))

(define (permutation xs ys qs rs)
  (cond [(not (null? xs))
         (permutation (cdr xs) (cons (car xs) ys) qs
                      (permutation (append-reverse ys (cdr xs))
                                   '() (cons (car xs) qs) rs))]
        [(null? ys) (cons qs rs)]
        [else rs]))

(reverse (map reverse (permutation '(0 1 2) '() '() '())))
