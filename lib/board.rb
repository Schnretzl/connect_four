require_relative 'player'

class Board
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end
end