file = File.open("day8.txt")
input = file.readlines.map(&:chomp)

def decode_line( line )
  keys,vals = line.split("|")
  keys = keys.split(" ").map(&:strip).map{|s| s.chars.sort(&:casecmp)}
  patterns = []
  patterns[8] = keys.select{ |k| k.size == 7}.first
  patterns[1] = keys.select{ |k| k.size == 2}.first
  patterns[4] = keys.select{ |key| key.size == 4}.first
  patterns[7] = keys.select{ |key| key.size == 3}.first
  patterns[2] = keys.select{ |k| k.size == 5 && (k - patterns[4]).size ==3 }.first
  patterns[3] = keys.select{ |k| k.size == 5 && (k - patterns[1]).size ==3 }.first
  patterns[9] = keys.select{ |k| k.size == 6 && (k - patterns[4]).size ==2 }.first
  l1 = patterns[8] - patterns[3]
  patterns[0] = keys.select{ |k| k.size == 6 && (k - l1 - patterns[1]).size ==2 }.first
  patterns.each { |known| keys.delete known}
  patterns[5] = keys.select{ |key| key.size == 5}.first
  patterns[6] = keys.select{ |key| key.size == 6}.first
  patterns.map!(&:join)

  vals = vals.split(" ").map(&:strip).map{|s| s.chars.sort(&:casecmp).join}
  vals.map{|val| patterns.find_index val}.join
end

out = input.map do |line|
  decode_line line
end

easies = %w{ 1 4 7 8 }
easy = out.reduce(0) do |sum, val|
  sum + val.chars.select{ |c| easies.include? c}.size
end
puts easy

puts "sum #{ out.map(&:to_i).sum}"
