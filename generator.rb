class SudokuGenerator

  class << self

    def conflicts(current_values, test)
      current_values.each do |s|
        if ( s.column == test.column or s.row == test.row or s.region == test.region) then
          return true if s.value == test.value
        end
      end

      false
    end

    def get_region(n) 
      column = n%9
      row = n/9
      return 1 if (column>=0 and column<=2 and row>=0 and row<=2)
      return 2 if (column>=3 and column<=5 and row>=0 and row<=2)
      return 3 if (column>=6 and column<=8 and row>=0 and row<=2)
      return 4 if (column>=0 and column<=2 and row>=3 and row<=5)
      return 5 if (column>=3 and column<=5 and row>=3 and row<=5)
      return 6 if (column>=6 and column<=8 and row>=3 and row<=5)
      return 7 if (column>=0 and column<=2 and row>=6 and row<=8)
      return 8 if (column>=3 and column<=5 and row>=6 and row<=8)
      return 9 if (column>=6 and column<=8 and row>=6 and row<=8)
    end

    def item(value,index) #given value and index returns square object
      Square.new(index%9, index/9, get_region(index), value, index)
    end

    def generate
      squares = Array.new(81) { Square.new(-1,-1,-1,-1,-1) }
      available = Array.new(81)
      current_square=0

      (0..80).each do |x|
        available[x] = [1,2,3,4,5,6,7,8,9]
      end

      while (current_square != 81) do
        if (available[current_square].length != 0) then
          index = rand(0..available[current_square].length-1)
          value = available[current_square][index]

          square_obj = item(value, current_square)

          if (conflicts(squares, square_obj) == false) then
            squares[current_square] = square_obj
            available[current_square].delete_at(index)
            current_square += 1
          else
            available[current_square].delete(value)
          end
        else 
          available[current_square] = []
          available[current_square] = [1,2,3,4,5,6,7,8,9]

          squares[current_square-1] = Square.new(-1,-1,-1,-1,-1)
          current_square -= 1
        end
      end
      matrix = squares.map { |square| square.value }
      sudoku = []
      (0..8).each { |i| sudoku << matrix[9*i..9*i+8] }

      SudokuGrid.new sudoku
    end
  end
end