file = File.open("day10.txt")
input = file.readlines.map(&:chomp)

open = %w{ ( \{ [ < }
closers = {
    "{" => "}",
    "[" => "]",
    "(" => ")",
    "<" => ">"
}

scores = {
    "}" => 1197,
    "]" => 57,
    ")" => 3,
    ">" => 25137
}

output = input.reduce([]) { |rejects, line|
  stack = []
  rejects.push(line.chars.reduce([]) { |errs, c|
    if errs.empty?
      if open.include? c
        stack.push c
      else
        if closers[stack.last] != c
          errs.push c
        else
          stack.pop
        end
      end
    end
    errs
  })
}.flatten
puts "SCORE #{output.reduce(0) { |sum, err|
  sum + scores[err]
}}"
