file = File.open("day2.txt")
file_data = file.readlines.map(&:chomp)

#looking back this is way overkill, but often advent will continue iterating on a solution and I thought that was the case here, so I went with a crude parser/lexer
class Sub
  attr_accessor :depth, :hpos

  class Command
    attr_accessor :pattern, :fun

    def initialize(pattern, fun)
      @pattern = pattern
      @fun = fun
    end
  end

  def initialize
    @aim = @hpos = @depth = 0
    @keywords = %w{ forward down up }
    @commands = [
        Command.new('forward <INT>',
                    lambda { |num|
                      @hpos += num
                      @depth += @aim * num
                    }),
        Command.new('down <INT>',
                    lambda { |num| @aim += num }),
        Command.new('up <INT>',
                    lambda { |num| @aim -= num })
    ]
  end

  def do_sub_things(data)
    data.each_with_index do |line, line_num|
      symbols = get_symbols line
      pattern = symbols.map { |s| s[:type] }.join(" ")
      puts "#{line_num} #{pattern}"
      command = @commands.select { |cmd| cmd.pattern == pattern }
      if command.first
        params = symbols.map { |sym| (sym.key? :val) ? sym[:val] : nil }.compact
        command.first.fun.call(*params)
      end
    end
  end

  private

  def get_symbols(line)
    line.split(" ").map do |token|
      if token =~ /\A\d+\Z/
        {type: '<INT>', val: token.to_i}
      elsif @keywords.select { |keyword| keyword == token }.first
        {type: token}
      else
        {type: "UNKNOWN"}
      end
    end
  end
end

sub = Sub.new
sub.do_sub_things file_data
puts "depth= #{sub.depth}  hpos= #{sub.hpos}"
