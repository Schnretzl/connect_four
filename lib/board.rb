require_relative 'player'
require 'rainbow'

class Board
  attr_accessor :player1, :player2, :grid

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

  def print_board
    max_color_size = @grid.flatten.compact.map(&:size).max || 0
    delimiter = "+" + ("-" * (max_color_size + 2) + "+") * @grid.first.length

    puts delimiter
    5.downto(0) do |row|
      row_output = @grid[row].map do |item|
        item.nil? ? " " * max_color_size : item.ljust(max_color_size)
      end.join(" | ")
      puts "| " + row_output + " |"
      puts delimiter
    end
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
    down_left_to_up_right? || down_right_to_up_left?
  end

  def down_left_to_up_right?
    diagonal_array = []
    3.times do |row|
      4.times do |column|
        diagonal_array << @grid[row][column] << @grid[row + 1][column + 1] << @grid[row + 2][column + 2] << @grid[row + 3][column + 3]
        return true if diagonal_array.compact.length == 4 && diagonal_array.compact.uniq.length == 1

        diagonal_array.clear
      end
    end

    false
  end

  def down_right_to_up_left?
    diagonal_array = []
    3.times do |row|
      6.downto(3) do |column|
        diagonal_array << @grid[row][column] << @grid[row + 1][column - 1] << @grid[row + 2][column - 2] << @grid[row + 3][column - 3]
        return true if diagonal_array.compact.length == 4 && diagonal_array.compact.uniq.length == 1

        diagonal_array.clear
      end
    end

    false
  end
end


# [
#   0: [0, 1, 2, 3, 4, 5, 6]
#   1: [0, 1, 2, 3, 4, 5, 6]
#   2: [0, 1, 2, 3, 4, 5, 6]
#   3: [0, 1, 2, 3, 4, 5, 6]
#   4: [0, 1, 2, 3, 4, 5, 6]
#   5: [0, 1, 2, 3, 4, 5, 6]
# ]