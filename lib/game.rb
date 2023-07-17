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

# player1_name = input_valid_player_name(1)
# verify_input(player1_name)
# player2_name = input_valid_player_name(2)
# verify_input(player2_name)