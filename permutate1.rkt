;; iterative permutation generator
;; puts results on the heap instead of the stack
;; runs in O(n!)
;; works by recursively taking one element from the current list
;;  and moving it to the front

(define (append-reverse hs ts)
  (if (null? hs) ts (append-reverse (cdr hs) (cons (car hs) ts))))

(define (permutate xs ys as bs qs rs)
  (cond [(and (null? xs) (not (null? bs)) (not (null? (car bs))))
         (permutate (car bs) '() (cdr as) (cdr bs) (car as) rs)]
        [(and (null? xs) (not (null? bs)))
         (permutate xs ys (cdr as) (cdr bs) qs (cons (car as) rs))]
        [(and (not (null? xs)))
         (permutate (cdr xs) (cons (car xs) ys)
                    (cons (cons (car xs) qs) as)
                    (cons (append-reverse ys (cdr xs)) bs) qs rs)]
        [else ;;and/or (null? as) (null? bs)
         rs]))

(define (permutate-nice xs)
  ;;rearrange for nicer viewing
  (map reverse (permutate '() '() '(()) (list xs) '() '())))

(permutate-nice '(0 1 2))
;; (permutate-nice '(0 1 2 3 4 5 6 7))
