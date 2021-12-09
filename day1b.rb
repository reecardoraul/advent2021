#file = File.open("day1a.txt")
#test_data = file.readlines.map(&:chomp)
test_data = [199,200,208,210,200,207,240,269,260,263]

def slide_3x(nums)
  count = nums.length-2
  increased = 0
  (1..count).each { |i|
    a=nums.slice(i-1,3).map(&:to_i)
    b=nums.slice(i,3).map(&:to_i)
    increased+= (b.sum > a.sum) ? 1 : 0
  }
  increased
end

increased = slide_3x test_data
puts increased
puts increased == 5
