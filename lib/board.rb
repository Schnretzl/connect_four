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
    if column_is_full?(column_number)
      puts 'Column number 0 is full, please play in another column'
    else
      @grid[empty_slot_index][column_number] = color
    end
  end

  def column_is_full?(column_number)
    @grid.transpose[column_number].none?(nil)
  end

  def winner?
    column_win = column_winner?
    row_win = row_winner?
    diagonal_win = diagonal_winner?
    column_win || row_win || diagonal_win
  end

  private

  def column_winner?
    @grid.transpose.each do |column|
      column.each_cons(4) do |group|
        return true if group.compact.uniq.length == 1 && !group.any?(nil)
      end
    end

    false
  end

  def row_winner?
    @grid.each do |row|
      row.each_cons(4) do |group|
        return true if group.compact.uniq.length == 1 && !group.any?(nil)
      end
    end

    false
  end

  def diagonal_winner?
    2.times do |start_row|
      3.times do |start_col|
        diagonal = [
          @grid[start_row][start_col..start_col + 3],
          @grid[start_row + 1][start_col..start_col + 3],
          @grid[start_row + 2][start_col..start_col + 3],
          @grid[start_row + 3][start_col..start_col + 3]
        ]
        return true if diagonal.flatten.compact.uniq.length == 1
      end
    end

    false
  end
end
  # [
  #   [0, 1, 2, 3, 4, 5, 6]
  #   [0, 1, 2, 3, 4, 5, 6]
  #   [0, 1, 2, 3, 4, 5, 6]
  #   [0, 1, 2, 3, 4, 5, 6]
  #   [0, 1, 2, 3, 4, 5, 6]
  #   [0, 1, 2, 3, 4, 5, 6]
  # ]