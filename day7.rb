@input = File.open("inputs/day7_input.txt").readlines.first.split(',').map { |x| x.to_i }

def calculate
  cost = nil
  0..@input.max do |i|
    fuel_cost = 0
    @input.each { |pos| fuel_cost += yield(pos, i) }
    cost = cost.nil? ? fuel_cost : [fuel_cost, cost].min
  end
  cost
end

pp calculate { |pos, i| (pos - i).abs } # part1
pp calculate { |pos, i| ((pos - i).abs)*(((pos - i).abs)+1) / 2 } # part2