require_relative 'board'

class Player
  def initialize(name, color)
    @name = name
    @color = color
  end

  def play(board, column_number)
    board.add_token(column_number)
  end
end