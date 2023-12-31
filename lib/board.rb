require_relative 'player'
require 'rainbow'

class Board
  attr_accessor :player1, :player2, :grid, :current_player_turn

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @grid = Array.new(6) { Array.new(7) }
    @current_player_turn = @player1
  end

  def add_token(column_number)
    empty_slot_index = @grid.transpose[column_number].find_index(nil)
    if column_is_full?(column_number)
      puts "Column number #{column_number} is full, please play in another column"
    else
      @grid[empty_slot_index][column_number] = @current_player_turn.name
    end
  end

  def column_is_full?(column_number)
    return nil if column_number < 0 || column_number > 6

    @grid.transpose[column_number].none?(nil)
  end

  def board_is_full?
    @grid.flatten.none?(nil)
  end

  def winner?
    column_win = column_winner?
    row_win = row_winner?
    diagonal_win = diagonal_winner?
    column_win || row_win || diagonal_win
  end

  def print_board
    max_name_size = [player1.name.length, player2.name.length].max || 0
    delimiter = "+" + ("-" * (max_name_size + 2) + "+") * @grid.first.length

    puts delimiter
    5.downto(0) do |row|
      row_output = @grid[row].map do |item|
        if item.nil?
          " " * max_name_size
        else
          color = get_color_by_player_name(item)
          colored_item = Rainbow(item.ljust(max_name_size)).background\
            (color.to_sym)
          colored_item
        end
      end.join(" | ")
      puts "| " + row_output + " |"
      puts delimiter
    end

    index_labels = (1..@grid.first.length).map { |num| num.to_s.ljust(max_name_size) }.join(" | ")
    puts "| " + index_labels + " |"
    puts delimiter
  end

  def change_current_player_turn
    @current_player_turn = @current_player_turn == @player1 ? @player2 : @player1
  end

  def prompt_for_play_column
    loop do
      puts "#{current_player_turn.name}, which column would you like to play in?(1-7)"
      column = STDIN.gets.chomp.to_i - 1
      if column_is_full?(column)
        puts "Column #{column} is full, please try another column."
        next
      end
      return column if (0..6).cover?(column)

      puts 'Invalid column entered, please enter only a number in the range 1-7.'
    end
  end

  def congratulate_winner
    puts "Congratulations, #{@current_player_turn.name}!  You win!"
  end

  def print_game_draw
    puts 'No moves left, game ends in a draw.'
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

def get_color_by_player_name(player_name)
  player1.name == player_name ? player1.color : player2.color
end
