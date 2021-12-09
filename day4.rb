file = File.open("day4.txt")
input = file.readlines.map(&:chomp)

def pivot_array(input)
  p = Array.new(5)
  input.each_with_index do |inner, x|
    inner.each_with_index do |val, y|
      p[y]=Array.new(5) unless p[y]
      p[y][x] = val
    end
  end
  p
end

def sum_card(card, called)
  card.reduce(0) do |acc, line|
    line_sum = (line - called).map(&:to_i).sum
    acc + line_sum
  end
end

sequence = input.first.split(",")
input = input.drop 2

ccard = []
cards = []
input.each do |line|
  if line.strip.empty?
    cards.push ccard
    ccard = []
  else
    ccard.push line.split(" ")
  end
end
cards.push ccard

called = []
winners = {}
sequence.each do |num|
  called.push num
  cards.each_with_index do |card, index|
    pivot = pivot_array card
    cp = [card,pivot]
    winner1= cp.select { |ccard|
      ccard.select { |line| (line - called).empty? }.any?
    }.any?
    if winner1
      winners[index]=index
      sum = sum_card(card,called)
      if winners.size == cards.size
        puts "WSIZE #{winners.size} index #{index} SUM #{sum} * NUM #{num} = #{sum * num.to_i}"
        puts "#{index} with sum #{sum}"
        exit
      end
    end
  end
end





