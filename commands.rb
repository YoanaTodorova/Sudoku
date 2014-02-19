class SudokuCommands
  def initialize grid
    @grid = grid
  end

  def pretty_print
    rows, cols = 0, 0
    @grid.each do |row|
      rows += 1
      row.each do |number|
        cols += 1 
        print number.to_s + ' '
        print ' ' if cols % 3 == 0
      end
      print "\n"
      print "\n" if rows % 3 == 0
    end
  end

  def has_no_duplicates? part
    part.each { |num| return false if num.to_i != 0 and part.count(num) > 1 }
  end

  def fill row, column, value
    @grid[row.to_i - 1][column.to_i - 1] = value
  end

  def check
    @grid.each { |row| has_no_duplicates? row }

    @grid.transpose.each { |column| has_no_duplicates? column }

    (1..3).each do |row|
      (1..3).each do |col|
        return false unless has_no_duplicates? @grid[3*row-3..3*row-1].map { |r| r[col*3-3..col*3-1] }.flatten
      end
    end
    true
  end
end