require "byebug"
require "singleton"

module Stepable
  def moves
    # [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[-1,2],[1,-2],[-1,-2]]
    move_diffs.map { |diffs| [@pos[0] + diffs[0], @pos[1] + diffs[1]] }.select { |pos| valid_move?(pos) }
  end
end

module Pawnable
  def moves
  
  end
end

module Slidable
  attr_reader :grow_unblocked_moves_in_dir

  # do we make variables private class variables???
  HORIZONTAL_DIRS = [[1,0], [-1,0], [0,1], [0,-1]]
  DIAGONAL_DIRS = [[1,1], [-1,1], [1,-1], [-1,-1]]
  
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    move_dirs.inject([]) { |total_moves, dirs| total_moves += grow_unblocked_moves_in_dir(*dirs) }
  end

  private
  def grow_unblocked_moves_in_dir(dx, dy)
    # debugger
    unblocked_moves = [] 
    pos_tracker = [@pos[0] + dx , @pos[1] + dy]

    while valid_move?(pos_tracker)
      pos_tracker = [pos_tracker[0] + dx , pos_tracker[1] + dy]
      unblocked_moves << pos_tracker if valid_move?(pos_tracker)
    end  

    unblocked_moves
  end
end

class Piece
  attr_reader :board

  # :R => Rook, :B => Bishop, :Q => Queen
  # :Kn => Knight, :K => King
  # :P => Pawn

  def initialize(symbol, board, pos)
    @color = symbol
    @board = board
    @pos = pos
  end

  def to_s
    @color.to_s
  end 
  
  def valid_move?(pos)
    pos.all? {|el| el >= 0 && el <= 7} && @board[pos].nil? 
  end 
end

class SlidingPiece < Piece
  include Slidable

  def symbol
    @color
  end

  def move_dirs
    case @color
    when :R
      HORIZONTAL_DIRS
    when :B
      DIAGONAL_DIRS
    when :Q
      HORIZONTAL_DIRS + DIAGONAL_DIRS
    end
  end
end

class SteppingPiece < Piece
  include Stepable

  def move_diffs
    case @color
    when :H
      [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[-1,2],[1,-2],[-1,-2]]
    when :K
      [[1,1],[1,-1],[-1,1],[-1,-1],[1,0],[-1,0],[0,1],[0,-1]]
    end
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :N
    @pos = [] 
  end 

end

class PawnPiece < Piece
  include Pawnable
end