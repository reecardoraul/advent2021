#data = File.open("day1a.txt").readlines.map(&:chomp).map(&:to_i)
data = [199,200,208,210,200,207,240,269,260,263]

def get_increased(data)
  increased = -1
  data.reduce do |last,current|
    if current > last
      increased+=1
    end
    current
  end
  increased
end
increased = get_increased data
test_answer = 7
puts "#{increased} == #{test_answer} #{increased==test_answer}"


