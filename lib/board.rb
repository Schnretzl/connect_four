require_relative 'player'

class Board
  attr_reader :player1, :player2, :grid
  
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @grid = Array.new(6) { Array.new(7) }
  end

  def add_token(column_number, color)
    empty_slot_index = @grid.transpose[column_number].find_index(nil)
    grid[empty_slot_index][column_number] = color
  end
end
