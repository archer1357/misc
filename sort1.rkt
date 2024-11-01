(define (partition x ys ls rs)
  (if (null? ys)
      (values ls rs)
      (let* ([c (<= (car ys) x)]
             [ls2 (if c (cons (car ys) ls) ls)]
             [rs2 (if c rs (cons (car ys) rs))])
        (partition x (cdr ys) ls2 rs2) )))

(define (qsort xs)
  (if (null? xs)
      '()
      (let* ([h (car xs)]
             [r (cdr xs)])
        (let-values ([(ls rs) (partition h r '() '())])
          (append (qsort ls) (cons h (qsort rs))) ))))

(define (ordered? xs)
  (or (null? xs)
      (null? (cdr xs))
      (and (<= (car xs) (cadr xs))
           (ordered? (cdr xs)) )))

(define (shift xs qs)
  (cond [(null? xs)
         (reverse qs)]
        [(null? (cdr xs))
         (reverse (cons (car xs) qs))]
        [else
         (let ([a (car xs)]
               [b (cadr xs)]
               [r (cddr xs)])
           (if (<= a b)
               (shift (cons b r) (cons a qs))
               (shift (cons a r) (cons b qs)) ))]))

(define (bsort xs)
  (if (ordered? xs)
      xs
      (bsort (shift xs '())) ))

(define (split xs ls rs)
  (cond [(null? xs)
         (values ls rs)]
        [(null? (cdr xs))
         (values (cons (car xs) ls) rs)]
        [else
         (split (cddr xs) (cons (car xs) ls) (cons (cadr xs) rs)) ]))

(define (merge xs ys qs)
  (cond [(and (null? xs) (null? ys))
         (reverse qs)]
        [(null? xs)
         (merge '() (cdr ys) (cons (car ys) qs))]
        [(null? ys)
         (merge (cdr xs) '() (cons (car xs) qs))]
        [(< (car xs) (car ys))
         (merge (cdr xs) ys (cons (car xs) qs))]
        [else
         (merge xs (cdr ys) (cons (car ys) qs)) ]))

(define (msort xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (let-values ([(ls rs) (split xs '() '())])
        (merge (msort ls) (msort rs) '()) )))

(let* ([xs '(5 3 8 6 14 1 9 0 13 2 4)]
       [qb (qsort xs)]
       [bb (bsort xs)]
       [mb (msort xs)])
  (display (format "unsorted ~A~n" xs))
  (display (format "quick sorted b ~A~n" qb))
  (display (format "bubble sorted b ~A~n" bb))
  (display (format "merge sorted b ~A~n" mb)) )
