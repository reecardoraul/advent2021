#input=%w{00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010}
file = File.open("day3.txt")
input = file.readlines.map(&:chomp)
strings=Array.new(12,"")
input.each { |s| s.chars.each_with_index{|b,i|
  strings[i]+=b
}} #pivot
gamma = strings.map { |s|
  zaros = s.scan(/0/).count
  ones = s.scan(/1/).count
  zaros > ones ? "0" : "1"
}.join
epsilon = gamma.chars.map { |zaro| zaro == "0" ? "1" : "0" }.join
puts "gamma #{gamma}-#{gamma.to_i(2)} eps #{epsilon}-#{epsilon.to_i(2)} product #{gamma.to_i(2) * epsilon.to_i(2)}"
