class SudokuGrid
  include Enumerable
  
  def initialize array
    @grid = array || Array.new(9) { |x| Array.new(9) { |y| "0" }}
  end

  def each(&block)
    @grid.each(&block)
  end

  def [](index)
    @grid[index]
  end

  def []=(index, value)
    @grid[index]=value
  end

  def transpose
    @grid.transpose
  end

  def valid_cell_coordinates? row, column
    row.to_i >= 1 and row.to_i <=9 and column.to_i >= 1 and column.to_i <= 9
  end

  def valid_value? value
    value.to_i >= 1 and value.to_i <= 9
  end

end