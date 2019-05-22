require_relative 'piece.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8, NullPiece.instance) }

    knight = SteppingPiece.new(:H, self, [0,0])
    self[[0,0]] = knight

    queen = SlidingPiece.new(:Q, self,[7,7])
    self[[7,7]] = queen 

  end

  def move_piece(start_pos, end_pos)
    # [ ] - exception handling for outside board
    # [ ] - singleton null piece with references to all nils
    
    # begin
    #   if !self[start_pos].nil? && self[end_pos].nil?
    #     raise StandardError
    #   end
    # rescue StandardError
    #   p "Invalid move."
    # end

    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end
end

board = Board.new
board[[0,0]].moves
