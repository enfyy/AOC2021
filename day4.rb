@input = File.open("inputs/day4_input.txt").readlines.map { |line| line.strip }

def get_bingo_boards
  i = 2
  bingo_boards = []
  until i >= @input.count
    bingo_boards +=  [@input[i..i+4].map { |line| line.split(' ').map { |num| num.to_i}}]
    i += 6
  end
  bingo_boards
end

def part1
  bingo_boards = get_bingo_boards

  @input.first.split(',').map { |num| num.to_i}.each do |num|
    bingo_boards.each_with_index do |bingo, index|
      replaced = bingo.map { |row| row.map{|e| e == num ? nil : e}}
      bingo_boards[index] = replaced
      return num * replaced.flatten.compact.sum if replaced.any?{ |row| row.all?{ |e| e == nil }} || replaced.transpose.any? { |col| col.all?{ |e| e == nil }}
    end
  end
end

def part2
  bingo_boards = get_bingo_boards

  out = []
  bingo_board_count = bingo_boards.count
  @input.first.split(',').map { |num| num.to_i}.each do |num|
    bingo_boards.each_with_index do |bingo, index|
      replaced = bingo.map { |row| row.map{|e| e == num ? nil : e}}
      bingo_boards[index] = replaced
      if replaced.any?{ |row| row.all?{ |e| e == nil }} || replaced.transpose.any? { |col| col.all?{ |e| e == nil }}
        next if out.include?(index)
        if out.count == (bingo_board_count - 1)
          return num * replaced.flatten.compact.sum
        else
          out.append(index)
        end
      end
    end
  end
end

pp part1
pp part2