require_relative 'board'
require_relative 'player'

# player1 = Player.new('Wes', 'blue')
# player2 = Player.new('Not Wes', 'red')
# game_board = Board.new(player1, player2)

# player1.play(game_board, 0)
# player1.play(game_board, 0)
# player2.play(game_board, 0)
# player1.play(game_board, 3)
# player2.play(game_board, 5)

# game_board.print_board

def input_valid_player_name(player_number)
  loop do
    puts "Enter player #{player_number} name:"
    name = STDIN.gets.chomp
    return name if name =~ /\A[\p{Letter}\p{Mark}]+\z/

    puts 'Invalid name entered, please enter only letters.'
  end
end

def input_valid_color(taken_colors = '')
  loop do
    puts 'What color do you want to play as?'
    color = STDIN.gets.chomp
    if taken_colors.include?(color)
      puts "#{color.capitalize} has already been chosen, please pick another color."
    else
      begin
        Rainbow('Valid color check').bg(color.to_sym)
        return color
      rescue ArgumentError
        puts 'Invalid color entered or not a color.  Please enter a valid color.'
      end
    end
  end
end

p1 = Player.new(input_valid_player_name(1), input_valid_color)
p2 = Player.new(input_valid_player_name(2), input_valid_color(p1.color))
game_board = Board.new(p1, p2)

loop do
  game_board.print_board
  game_board.add_token(game_board.prompt_for_play_column)
  if game_board.winner?
    game_board.congratulate_winner
    break
  end
  if game_board.board_is_full?
    game_board.print_game_draw
    break
  end
  game_board.change_current_player_turn
end