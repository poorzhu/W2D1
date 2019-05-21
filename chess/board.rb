class Piece
  # [ ] - to_s method to automatically print pieces

  def to_s
    "P"
  end
end

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    [0,1,6,7].each do |row|
      @grid[row].map! { |tile| Piece.new }
    end
  end

  def move_piece(start_pos, end_pos)
    # [ ] - exception handling for outside board
    # [ ] - singleton null piece with references to all nils
    
    begin
      if self[start_pos].nil? || !self[end_pos].nil?
        raise StandardError
      end
    rescue StandardError
      p "Invalid move."
    end

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