@input = File.open("inputs/day3_input.txt").read.split("\n").map { |cmd| cmd.strip }

def get_rating(keep_majority)
  rows = @input.map{ |row| row.split('').map{ |num| num.to_i}}
  i = 0
  until rows.count == 1
    cols = rows.transpose
    cols[i].count(0) <= cols[i].count(1) ? rows.delete_if { |row| row[i] == (!keep_majority && 1 || 0) } : rows.delete_if { |row| row[i] == (keep_majority && 1 || 0) }
    i += 1
  end
  rows.first.join.to_i(2)
end

# part1
gamma_string = ''
@input.map{ |row| row.split('').map{ |num| num.to_i}}.transpose.each{ |col| col.count(0) < col.count(1) ? gamma_string += '1' : gamma_string += '0' }
pp gamma_string.to_i(2) * gamma_string.gsub('0', 'x').gsub('1', '0').gsub('x', '1').to_i(2) #lmao

#part2
pp get_rating(true) * get_rating(false)