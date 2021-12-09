file = File.open("day5.txt")
input = file.readlines.map(&:chomp)

def draw_canvas(canvas)
  canvas.each do |inner|
    puts inner.join(" ")
  end
end

def draw_line(canvas, x1, y1, x2, y2)
  if x1 == x2
    sorted = [y1, y2].sort
    (sorted.first..sorted.last).sort.each do |y|
      canvas[x1][y] += 1
    end
  elsif y1 == y2
    sorted = [x1, x2].sort
    (sorted.first..sorted.last).each do |x|
      canvas[x][y1] += 1
    end
  else
    #puts "SKIP #{x1},#{y1} -> #{x2},#{y2}"
    steps = (x1 - x2).abs
    (0..steps).each do |step|
      xdelta = x1 > x2 ? -1 : 1
      ydelta = y1 > y2 ? -1 : 1
      canvas[x1 + step * xdelta ][y1 + step * ydelta] += 1
    end
  end
end

SIZE=990.freeze
mill = Array.new(SIZE)
(0..SIZE).each { |x| mill[x] = Array.new(SIZE, 0) }

input.each do |line|
  #0,9 -> 5,9
  if /(\d+),(\d+) -> (\d+),(\d+)/ =~ line
    draw_line(mill, $2.to_i, $1.to_i, $4.to_i, $3.to_i)
  else
    puts "BUMMER #{line}"
  end
end

#draw_canvas mill

puts mill.reduce(0) { |sum, inner|
  sum + inner.select { |val| val > 1 }.count
}
# mill.each_with_index do |inner,x|
#   inner.each_with_index do |val,y|
#     if val > 1
#       puts "#{x},#{y}=#{val}"
#     end
#   end
# end

