
(define (partition-a x ys)
  (if (null? ys)
      (values '() '())
      (let-values ([(ls rs) (partition-a x (cdr ys))])
	(if (<= (car ys) x)
	    (values (cons (car ys) ls) rs)
	    (values ls (cons (car ys) rs))))))

(define (qsort-a xs)
  (if (null? xs)
      '()
      (let-values ([(ls rs) (partition-a (car xs) (cdr xs))])
	(append (qsort-a ls) (cons (car xs) (qsort-a rs))))))

(define (shift-a xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (let ([a (car xs)]
	       [b (cadr xs)]
	       [r (cddr xs)])
	   (if (<= a b)
	       (cons a (shift-a (cons b r)))
	       (cons b (shift-a (cons a r)))
	       ))))

(define (ordered? xs)
  (or (null? xs)
      (null? (cdr xs))
      (and (<= (car xs) (cadr xs))
	   (ordered? (cdr xs)))))
   

(define (bsort-a xs)
  (if (ordered? xs)
      xs
      (bsort-a (shift-a xs))
      ))
	  

(define (split-a xs)
  (if (or (null? xs) (null? (cdr xs)))
      (values xs '())
      (let-values ([(as bs) (split-a (cddr xs))])
	(values (cons (car xs) as) (cons (cadr xs) bs))
	)))

(define (merge-a xs ys)
  (cond [(null? xs) ys]
	[(null? ys) xs]
	[(< (car xs) (car ys))
	 (cons (car xs) (merge-a (cdr xs) ys))]
	[else
	 (cons (car ys) (merge-a xs (cdr ys)))
	 ]))
	 

(define (msort-a xs)
  (if (or (null? xs) (null? (cdr xs)))
      xs
      (let-values ([(ls rs) (split-a xs)])
	(merge-a (msort-a ls) (msort-a rs))
	)))
	

(define (append-a x y)
  (cond [(null? x) y]
	[(null? (cdr x)) (cons (car x) y)]
	[else (cons (car x) (append-a (cdr x) y))]))

;; (let* ([xs '(5 3 8 6 14 1 9 0 13 2 4)]
;;        [qa (qsort-a xs)]
;;        [ba (bsort-a xs)]
;;        [ma (msort-a xs)])
;;   (print (format "unsorted ~A" xs))
;;   (print (format "quick sorted a ~A" qa))
;;   (print (format "bubble sorted a ~A" ba))
;;   (print (format "merge sorted a ~A" ma))
;;   (print "done"))

(define (reverse-b x a)
  (if (null? x)
      a
      (reverse-b (cdr x) (cons (car x) a))))
(define (append-b x y)
  (append-b2 (reverse-b x '()) y))

(define (append-b2 x y)
  (if (null? x)
      y
      (append-b2 (cdr x) (cons (car x) y))))

;; (print (append-b '(1 2 3 4) '(5 6 7 8)))