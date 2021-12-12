@input = File.open('inputs/day8_input.txt').readlines.map { |line| line.strip.split('|') }

def part1
  count = 0
  @input.each { |line| count += line[1].split(" ").group_by {|val| val.length}.delete_if {|k,v| ![2,4,3,7].include?(k)}.values.flatten.count}
  count
end

def part2
  count = 0
  @input.each { |line| count += decode!(line[1].split(' '), find_segment_mapping(line[0].split(" ")))}
  count
end

def find_segment_mapping(signals)
  grouped_by_length = signals.group_by { |v| v.length }
  segment_map = {} # letter -> segment index
  nums = {} # number -> letter combination that results in that number

  #  111111
  #  2    3
  #  2    3
  #  444444
  #  5    6
  #  5    6
  #  777777

  #find the numbers that have unique length
  nums[1] = grouped_by_length[2]
  nums[4] = grouped_by_length[4]
  nums[7] = grouped_by_length[3]
  nums[8] = grouped_by_length[7]

  #find the number 3 because its the only combo that contains both numbers that are also contained in the number 1
  nums[3] = grouped_by_length[5].select { |five_length_combo| five_length_combo.delete(nums[1].first).length == 3 }

  #find the number 5 because it has length 2 after subtracting the letters included in number 4 and its not the number 3
  nums[5] = grouped_by_length[5].select { |five_length_combo| five_length_combo.delete(nums[4].first).length == 2 && !nums[3].include?(five_length_combo)}

  #find the number 2 because its the other one out of the 3
  nums[2] = grouped_by_length[5].select { |five_length_combo| !nums[3].include?(five_length_combo) && !nums[5].include?(five_length_combo) }

  #find the number 9 because it has length 1 after subtracting the letters included in number 3
  nums[9] = grouped_by_length[6].select { |six_length_combo| six_length_combo.delete(nums[3].first).length == 1 }

  #find the number 6 because it has length 4 after subtracting the letters included in number 7 and its not number 9
  nums[6] = grouped_by_length[6].select { |six_length_combo| six_length_combo.delete(nums[7].first).length == 4 && !nums[9].include?(six_length_combo) }

  #find the number 0 because the other one left
  nums[0] = grouped_by_length[6].select { |six_length_combo| !nums[6].include?(six_length_combo) && !nums[9].include?(six_length_combo)}

  sorted_nums = {}
  nums.each { |k,v| sorted_nums[k] = v.map { |p| p.split('')}.flatten.uniq.sort }

  # we now know which combos represent which number
  # length 2 and 3 are the numbers 1 and 7 so we can find out which letter is segment index 1
  one = grouped_by_length[3].first.delete(grouped_by_length[2].first)
  segment_map[one] = 1
  segment_map[sorted_nums[8].difference(sorted_nums[0]).first] = 4
  segment_map[sorted_nums[8].difference(sorted_nums[6]).first] = 3
  segment_map[sorted_nums[8].difference(sorted_nums[9]).first] = 5
  two = sorted_nums[9].difference(sorted_nums[3]).first
  segment_map[two] = 2
  segment_map[sorted_nums[0].difference(sorted_nums[2]).difference([two]).first] = 6
  segment_map[sorted_nums[9].difference(sorted_nums[4]).difference([two]).difference([one]).first] = 7

  # add the missing one
  if segment_map.count == 6
    missing_letter = 'abcdefg'.split("")
    segment_map.keys.each { |key| missing_letter.delete(key) }
    missing_number = (1..7).to_a
    segment_map.values.each { |value| missing_number.delete(value) }
    segment_map[missing_letter.first] = missing_number.first
  end
  segment_map
end

def decode!(output_patterns, segment_map)
  result = ""
  output_patterns.each do |pattern|
    digit = nil
    code = pattern.split('').map { |c| segment_map[c].to_s }.sort.join
    case code
    when '123567'
      digit = 0
    when '36'
      digit = 1
    when '13457'
      digit = 2
    when '13467'
      digit = 3
    when '2346'
      digit = 4
    when '12467'
      digit = 5
    when '124567'
      digit = 6
    when '136'
      digit = 7
    when '1234567'
      digit = 8
    when '123467'
      digit = 9
    else
      pp "SOMETHING WENT WRONG. CODE WAS #{code}"
    end

    result += digit.to_s
  end
  result.to_i
end

pp part1
pp part2