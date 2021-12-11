file = File.open("day9.txt")
input = file.readlines.map(&:chomp)

def get_neighbors(x,y,grid)
  neighbors = []
  neighbors.push( grid[y][x-1]) unless x == 0
  neighbors.push( grid[y][x+1]) unless x >= grid.first.size-1
  neighbors.push( grid[y-1][x]) unless y == 0
  neighbors.push( grid[y+1][x]) unless y >= grid.size-1
  neighbors
end

def part1(input)
  minimums = []
  (0..input.length-1).each do |y|
    line = input[y]
    (0..line.length-1).each do |x|
      val = line[x].to_i
      neighbors = get_neighbors(x,y,input)
      lt = neighbors.select{ |neigbor| neigbor.to_i <= val }
      if lt.size == 0
        minimums.push val
        puts "X #{x} Y#{y} VAL #{val} neighbors #{neighbors}"
      end
    end
  end
  minimums
end

#2
class Point
  attr_accessor :x, :y, :val, :visited
  def initialize(x, y, val)
    @x=x
    @y=y
    @val = val
    @visited = false
  end
end

#recursion bad, should have used a queue but recursion is more fun :-)
def explore_basin(topography, x,y)
  point = topography[y][x]
  return unless point.val < 9 && point.visited==false
  point.visited=true
  basin = []
  basin.push(point)
  basin.push(explore_basin( topography,x-1, y)) unless x == 0
  basin.push(explore_basin( topography,x+1, y)) unless x >= topography.first.size-1
  basin.push(explore_basin( topography,x,y-1)) unless y == 0
  basin.push(explore_basin( topography,x,y+1)) unless y >= topography.size-1
  basin.flatten.compact
end

def part2(input)
  topography = input.each_with_index.map{|row, y|
    row.chars.each_with_index.map{|val, x| Point.new(x,y,val.to_i)}
  }
  basins=[] #reducer
  topography.each_with_index.map do |row,y|
    row.each_with_index do |cxy,x|
      basin = explore_basin(topography, x, y)
      basins.push(basin) unless basin.nil?
    end
  end
  basins
end

minimums = part1(input)
puts minimums
puts minimums.reduce(0){|sum,val| sum + val + 1}

basins = part2(input)
basins.map(&:size).sort.reverse.slice(0,3).reduce(1) do |acc,basin|
  puts "#{basin} - #{acc * basin}"
  acc * basin
end
