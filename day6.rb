@input = File.open("inputs/day6_input.txt").readlines.first.split(',').map { |x| x.to_i }

def simulate(day_count)
  age = {} # age -> fish count
  (0..8).each {|i| age[i] = @input.count(i)}

  day_count.times do
    age.transform_keys! { |k| k-1 }
    complete = age.delete(-1)
    age[8] = complete
    age[6] += complete
  end
  age.values.sum
end

pp simulate(80)
pp simulate(256)