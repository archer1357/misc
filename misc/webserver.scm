(use-modules (web server)
             (web request)
             (web response)
             (sxml simple)
             (ice-9 pretty-print))

(define (on-response request body)
  (values
   '((content-type text/html (charset . "utf-8")))
   home-page
 ))

(define (home-page port)
  (display "<!DOCTYPE html>\n" port)
  (sxml->xml
   '(html
     (head (title "abc"))
     (body
      (p "Hello")))
   port))

(run-server on-response 'http '(#:port 8081))
