require "colorize"
require_relative "board.rb"
require_relative "cursor.rb"
require "byebug"

class Display

  def initialize
    @board = Board.new
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system('clear')

    @board.grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        if @cursor.cursor_pos == [row_idx, col_idx]
          print tile.to_s.colorize(:red)
        else
          print tile.to_s
        end
      end
      puts
    end
  end 

  def make_move
    while true
      render
      @cursor.get_input
      
    end
  end

end

display = Display.new
display.make_move