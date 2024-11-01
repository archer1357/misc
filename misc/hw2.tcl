puts ----
set a 1235
set b "list 1 2 3"
puts $a
puts $b

puts ----
for {set i 0} {$i < 5} {incr $i} {
    puts $i
}

puts ----
puts [string first "e" "abcde"]
puts [lsearch -exact {a b c d e} b]
puts [lsearch -regexp {a b c d e} {[ed]}]

puts ----
puts [regexp {([a-z]+)([0-9]+)} "abc123def"]
puts [regexp {([a-z]+)([0-9]+)} "abc123def" q q1 q2]
puts $q
puts $q1
puts $q2

puts ----
puts [regsub -all "wrong" "is it wrong or wrong?" "correct"]
puts [regsub -all "wrong" "is it wrong or wrong?" "correct" res]
puts $res

puts ----

set qq 123
proc rr {a} {
  return [expr {$a * 9}]
}
puts [expr {1---5}]
