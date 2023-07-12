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
    if empty_slot_index && empty_slot_index <= 5
      @grid[empty_slot_index][column_number] = color
    else
      puts 'Column number 0 is full, please play in another column'
    end
  end

  def column_is_full?(column_number)
    @grid.transpose[column_number].none?(nil)
  end
end
