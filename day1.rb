@input = File.open("inputs/day1_input.txt").read.split("\n").map{|digit| digit.to_i}

def part1()
  last_measurement = @input.first
  count = 0
  @input.each_with_index do |measurement, index|
    next if index == 0
    increased = measurement > last_measurement
    count += 1 if increased
    #pp "#{last_measurement} (#{increased})"
    last_measurement = measurement
  end
  count
end

def part2()
  count = 0
  last_set = @input[0..2].sum
  @input.each_with_index do |measurement, index|
    next if index < 2
    set = @input[index-2..index].sum
    increased = set > last_set
    count += 1 if increased
    #pp "#{last_set} (#{increased})"
    last_set = set
  end
  count
end

puts part1()
puts part2()