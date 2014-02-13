class SudokuGame
  FILL_COMMAND = /^fill( )+\[( )*([0-9]+)( )*,( )*([0-9]+)( )*\]( )*=( )*([0-9]+)$/
  
  def initialize
    @puzzle = SudokuGenerator.generate
    #@commands = SudokuCommands.new @puzzle
    #puts "\nHere is your sudoku: \n\n"
    #@commands.pretty_print
  end

  def get_user_input
    while (input = gets.chomp) != "exit" do
      case input
      when "print" then @commands.pretty_print
      when  FILL_COMMAND
        @commands.fill $3, $6, $10 if valid_user_input? $3, $6, $10
      when "check" then puts @commands.check
      else puts "Invalid command!"
      end
    end
  end

  def valid_user_input? row, column, value
    @puzzle.valid_cell_coordinates?(row, column) and @puzzle.valid_value? value
  end

  alias start get_user_input
end