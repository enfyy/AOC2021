@input = File.open("inputs/day2_input.txt").read.split("\n").map { |cmd| cmd.strip }

def part1()
  x = y = 0
  @input.each do |command|
    steps = command.split(' ')[1].to_i
    x += steps if command.start_with?('forward')
    y += steps if command.start_with?('down')
    y -= steps if command.start_with?('up')
  end
  x * y
end

def part2()
  x = y = aim = 0
  @input.each do |command|
    steps = command.split(' ')[1].to_i
    if command.start_with?('forward')
      x += steps
      y += aim * steps
    end
    aim += steps if command.start_with?('down')
    aim -= steps if command.start_with?('up')
  end
  x * y
end

pp part1()
pp part2()