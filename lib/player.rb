require_relative 'board'

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play(board, column_number)
    board.add_token(column_number, @color)
  end
end