input = %w{00100 11110 10110 10111 10101 01111 00111 11100 10000 11001 00010 01010}

#file = File.open("day3.txt")
#input = file.readlines.map(&:chomp)

def pivot_array(input)
  p = Array.new(input.first.length, "")
  input.each { |s| s.chars.each_with_index { |b, i|
    p[i] += b
  } }
  p
end
on_off = %w[0 1]
on_off.each do |tie_goes_to|
  other = (on_off - [tie_goes_to]).first
  current = input
  index = 0
  while current.length > 1 && index < input[0].length do
    pivot = pivot_array current
    s = pivot[index]
    zeros = s.scan(/0/).count
    ones = s.scan(/1/).count
    which = if zeros > ones
              other
            elsif ones > zeros
              tie_goes_to
            else
              tie_goes_to
            end
    current = current.filter{ |bin| bin[index] == which }
    index+=1
  end
  puts "#{current.first} = #{current.first.to_i(2)}"
end