(module cbind racket
  (require ffi/unsafe
           racket/pretty)

  ;;(define-runtime-path curpath ".")

  (define (get-exec-name)
    (if (equal? 'windows (system-type))
        "cextract.exe"
        "cextract"))
  ;;(path->string (simplify-path curpath))

  (define (cextract . args)
    (match-let
      ([(list in out pid inerr proc)
        (apply process*
               (list*
                (path->string (find-executable-path (get-exec-name)))
                args))])
      (let* ([s (read in)]
             [c (proc 'exit-code)])
        (printf (port->string inerr))
        (close-input-port in)
        (close-output-port out)
        (close-input-port inerr)

        ;;(if (and (not (equal? 0 c)) c)
        ;;    (begin
        ;;      (printf "cextract: error-code=~a~n" c)
        ;;      (error ""))
        ;;    s)
        s)))

  (define (norm-path-string p)
    (path->string (simplify-path (normal-case-path (string->path p)))))

  (define (type->ctype q)
    (match q
      [`(pointer (function ,a ...))
       (type->ctype `(function ,@a))]
      [`(pointer ,a)
       '_mypointer]
      ;;`(let ([aa ,(type->ctype a)])
      ;;  (if (ffi-callback? aa) aa _mypointer))]
      [`(array ,s ,a ...)
       `(make-array-type ,(type->ctype (car a)) ,s)]
      [`(function ,r ,ps ...)
       `(make-ctype
         (_fun ,@(map type->ctype ps) -> ,(type->ctype r))
         mypointer-cast-c #f)]
      [`(reference ,a) a]
      ["ptrdiff_t" '_int]
      ["unsigned int" '_uint]
      ["size_t" '_uint]
      ["unsigned short" '_ushort]
      ["unsigned char" '_ubyte]
      ["signed char" '_byte]
      ["char" '_byte]
      ["unsigned long" '_ulong]
      ["long long" '_llong]
      ["unsigned long long" '_ullong]
      ["int64_t" '_int64]
      ["uint64_t" '_uint64]
      ["va_list" '_pointer]
      [else (if (string? q) (string->symbol (string-append "_" q)) #f)]))

  (define (stmt->code stmt)
    (match stmt
      [`(call ,f ,args ...)
       `(,(stmt->code f) ,@(map stmt->code args))]
      [`(ref ,idn) (string->symbol idn)]
      [`(op "&&" ,args ...)
       `(and
         ,@(map
            (lambda (x) `(let ([b ,(stmt->code x)]) (if (= 0 b) #f b)))
            args))]
      [`(op "||" ,args ...)
       `(or
         ,@(map
            (lambda (x) `(let ([b ,(stmt->code x)]) (if (= 0 b) #f b)))
            args))]
      [`(op "+" ,args ...)
       `(+ ,@(map stmt->code args))]
      [`(op "-" ,args ...)
       `(- ,@(map stmt->code args))]
      [`(op "*" ,args ...)
       `(* ,@(map stmt->code args))]
      [`(op "/" ,args ...)
       `(/ ,@(map stmt->code args))]
      [`(op "&" ,args ...)
       `(bitwise-and ,@(map stmt->code args))]
      [`(op "|" ,args ...)
       `(bitwise-or ,@(map stmt->code args))]
      [`(op "," ,args ...)
       `(begin ,@(map stmt->code args))]
      [`(op "==" ,args ...)
       `(= ,@(map stmt->code args))]
      [`(op "!=" ,args ...)
       `(not (= ,@(map stmt->code args)))]
      [`(op ">" ,args ...)
       `(> ,@(map stmt->code args))]
      [`(op ">=" ,args ...)
       `(>= ,@(map stmt->code args))]
      [`(op "<" ,args ...)
       `(< ,@(map stmt->code args))]
      [`(op "<=" ,args ...)
       `(<= ,@(map stmt->code args))]
      [else
       (cond [(string? stmt) (string->bytes/locale stmt)]
             [(number? stmt) stmt]
             [else `(error "func unimplemented" (quote ,stmt))])]))

  (define (get-define-object n v provide?)
    (let ([nsym (string->symbol n)])
      (list*
       `(define ,nsym ,(if (string? v) (string->bytes/locale v) v))
       (if provide? (list `(provide ,nsym)) null))))

  (define (get-define-function n ps v provide?)
    (let ([nsym (string->symbol n)])
      (list*
       `(define (,nsym ,@(map string->symbol ps))
          ,@(map stmt->code v))
       (if provide? (list `(provide ,nsym)) null)
       )))

  ;;(ffi-obj-ref n ,libsym (lambda () #f))

  (define (get-function n rt pts libsym getfuncsym provide?)
    (let ([nsym (string->symbol n)])
      (list*
       `(define ,nsym
          (let* ([t (_fun ,@(map type->ctype pts) -> ,(type->ctype rt))]
                 [f #f])
            (lambda l
              (unless f
                (set! f (or (and ,libsym (get-ffi-obj ,n ,libsym t
                                                      (lambda () #f)))
                            (and ,getfuncsym (function-ptr (,getfuncsym ,n)
                                                           t))
                            (error "func unimplemented" ,nsym))))
              (when f (apply f l)))))
       (if provide? (list `(provide ,nsym)) null)
       )))

  (define (get-enum n ens evs provide?)
    (let ([nsym (string->symbol (string-append "_" n))])
      (list*
       `(define ,nsym '_int)
       (append*
        (map
         (lambda (en ev)
           (let ([ensym (string->symbol en)])
             (list*
              `(define ,ensym ,ev)
              (if provide? (list `(provide ,ensym)) null))))
         ens evs)))))

  (define (get-typedef n t provide?)
    (let ([nsym (string->symbol (string-append "_" n))]
          [tt (type->ctype t)])
      (list*
       `(define ,nsym
          ,(if (and (list? t) (equal? 'function (car t)))
               `(let ([ttt ,tt])
                  (begin
                    ;;(set! typedef-funcsset (set-add typedef-funcsset ttt))
                    ttt))
               tt))
       (if provide? (list `(provide ,nsym)) null))))

  (define (get-union n s fs provide?)
    (let ([nsym (string->symbol (string-append "_" n))])
      (list*
       `(define ,nsym (make-array-type _byte ,s))
       ;;todo
       null)))

  (define (get-struct n s fs provide?)
    (let ([nsym (string->symbol (string-append "_" n))])
      (list*
       `(define ,nsym (make-array-type _byte ,s))
       ;;todo
       null)))

  (define mypointer
    '((define (mypointer-cast-c q) (if (number? q) (cast q _int _pointer) q))
      (define (mypointer-cast-s q) q)
      (define _mypointer
        (make-ctype _pointer mypointer-cast-c mypointer-cast-s))))

  (define (get-functions in libsym getfuncsym provide?)
    (append*
     (filter-map
      (lambda (x)
        (match x
           [`(function ,n ,rt ,pts ...)
            (get-function n rt pts libsym getfuncsym provide?)]
          [else #f]))
      in)))

  (define (get-enums in provide?)
    (append*
     (filter-map
      (lambda (x)
        (match x
          [`(enum ,n (,ens ,evs) ...) (get-enum n ens evs provide?)]
          [else #f]))
      in)))

  (define (get-structs-unions in provide?)
    (append*
     (filter-map
      (lambda (x)
        (match x
          [`(struct ,n ,s ,fs ...) (get-struct n s fs provide?)]
          [`(union ,n ,s ,fs ...) (get-union n s fs provide?)]
          [else #f]))
      in)))

  (define (get-typedefs in provide?)
    (append*
     (filter-map
      (lambda (x)
        (match x
          [`(typedef ,n ,t) (if (equal? n t) #f (get-typedef n t provide?))]
          [else #f]))
      in)))

  (define (get-defines in provide?)
    (append*
     (filter-map
      (lambda (x)
        (match x
          [`(define-object ,n ,v) (get-define-object n v provide?)]
          [`(define-function ,n (,ps ...) ,v ...)
           (get-define-function n ps v provide?)]
          [else #f]))
      in)))

  (define (cbind-print a) (pretty-print a))
  (define (cbind-write f a)
    (call-with-output-file f
      (lambda (o) (write-string (pretty-format a) o))
      #:exists 'replace))

  (provide cextract
           mypointer
           get-enums
           get-structs-unions
           get-typedefs
           get-functions
           get-defines
           cbind-print
           cbind-write))
;; (module CppToC racket
;;   (require racket/pretty)
(require xml)
(require racket/cmdline)

(define CExtract-path
  (let* ([w (if (equal? 'windows (system-type)) ".exe" "")]
         [e (string-append "CExtract" w)]
         [n (or (find-executable-path e)
                (find-executable-path (string-append "bin/" e)))])
    (if n
        (path->string n)
        (error "Couldn't find CExtract executable"))))

(define (CExtract-shell args)
  (match-let ([(list in out pid inerr proc)
               (apply process* (list* CExtract-path args))])
    (proc 'wait)
    (let* ([s (read in)] [c (proc 'exit-code)]
           [e (port->string inerr)])
      (close-input-port in)
      (close-output-port out)
      (close-input-port inerr)
      (if (equal? 0 c) s (error e)))))

(define (bla n)
  (match n
    [`(buffer) 1]
    [`(field (@ (access ,access)))
     ""]
    [`(field (@ (name ,n)))
     2]
    [else #f]))

(define (filter-CExtract-args args)
  (filter
   (lambda (x)
     (if (or (< (string-length x) 2)
             (string=? "-S" (substring x 0 2)))
         #f
         x))
   args))


(define (run args)
  (let* ([CExtract-args
          (list* "-output=c pp_sxml" (filter-CExtract-args args))]
         [top (CExtract-shell CExtract-args)])
    1))

(print (CExtract-shell '("-output=cpp_sxml" "test/hello.h")))
;; (run (vector->list (current-command-line-arguments)))
(bla 2)
