# Return next step in Conway's Game of Life for array 'cells'
def next_gen cells
  cells_next = Array.new(cells.length) { Array.new(cells[0].length) }
  cells.length.times do |x|
    cells[x].length.times do |y|

      surroundings = Array.new(3) { Array.new(3) }
      (-1..1).each do |a|
        (-1..1).each do |b|
          surroundings[a + 1][b + 1] = cells[x + a][y + b] unless cells[x + a].nil?
        end
      end
      surroundings[0] = [0, 0, 0] if x == 0
      3.times { |n| surroundings[n][0] = 0 } if y == 0
      surroundings[1][1] = 0
      sum = surroundings.flatten.compact.reduce(:+)

      if sum == 3 || sum == 2 && cells[x][y] == 1
        cells_next[x][y] = 1
      else
        cells_next[x][y] = 0
      end
    end
  end
  cells_next
end

require 'matrix'
def next_gen_best cells
  m = Matrix[*cells]
  cells.map.with_index{|row, i|
    row.map.with_index{|cell, j|
      {2 => cell, 3=> 1}[m.minor([i-1,0].max..(i+1), [j-1,0].max..(j+1)).reduce(:+) - cell] || 0
    }
  }
end
