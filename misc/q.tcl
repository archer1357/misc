proc foo {x y w z} {
  puts "$x $y $z $w"
}

proc woo {a} {
  return "1 $a 2"
}

# foo "[woo " 3 7 "]"
# puts "[woo {2 3}]"
# puts 'a'

set t 5
puts }a{$t}
