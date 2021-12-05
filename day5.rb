@input = File.open("inputs/day5_input.txt").readlines.map { |line| line.strip }

def part1
  grid = []
  (0..999).each {grid.append([].fill('.', 0..999))}
  @count = 0

  @input.each do |line|
    pair = line.split('->').map{ |pair| pair.strip.split(',')}.map { |pair| pair.map{ |num| num.to_i} }
    point1 = pair[0]
    point2 = pair[1]

    # vertical line
    if point1[0] == point2[0]
      iterator = point1[1] > point2[1] ? (point1[1].downto(point2[1])) : (point1[1]..point2[1])
      iterator.each { |num| increase_pos(grid, point1[0], num) }
    end

    # horizontal line
    if point1[1] == point2[1]
      iterator = point1[0] > point2[0] ? (point1[0].downto(point2[0])) : (point1[0]..point2[0])
      iterator.each { |num| increase_pos(grid, num, point1[1]) }
    end

  end
  @count
end

def increase_pos(grid, x, y)
  value_at_pos = grid[y][x]
  if value_at_pos == '.'
    grid[y][x] = 1
  else
    new_val = value_at_pos + 1
    @count += 1 if new_val == 2
    grid[y][x] = new_val
  end
end

def part2
  grid = []
  (0..999).each {grid.append([].fill('.', 0..999))}
  @count = 0

  @input.each do |line|
    pair = line.split('->').map{ |pair| pair.strip.split(',')}.map { |pair| pair.map{ |num| num.to_i} }
    point1 = pair[0]
    point2 = pair[1]
    dir = [dir(point2[0] - point1[0]), dir(point2[1] - point1[1])]
    iterator = point1
    until iterator == point2
      increase_pos(grid, iterator[0], iterator[1])
      iterator[0] += dir[0]
      iterator[1] += dir[1]
    end
    increase_pos(grid, iterator[0], iterator[1])
  end
  @count
end

def dir(num)
  if num.negative?
    return -1
  elsif num != 0
    return +1
  end
  0
end

pp part1
pp part2