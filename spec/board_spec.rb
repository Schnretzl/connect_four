require_relative '../lib/board'

describe Board do
  let(:player1) { double('Player') }
  let(:player2) { double('Player') }

  subject(:game_board) { described_class.new(player1, player2) }
  let(:grid) { game_board.instance_variable_get(:@grid) }

  describe '#add_token' do
    it 'Adds a black token to column 0' do
      game_board.add_token(0, 'black')
      expect(grid[0][0]).to eq 'black'
    end

    it 'Adds a red token on top' do
      game_board.add_token(0, 'black')
      game_board.add_token(0, 'red')
      expect(grid[1][0]).to eq 'red'
    end

    it 'Prints an error message if trying to play in a full column' do
      game_board.add_token(0, 'black')
      game_board.add_token(0, 'red')
      game_board.add_token(0, 'black')
      game_board.add_token(0, 'red')
      game_board.add_token(0, 'black')
      game_board.add_token(0, 'red')
      expect{ game_board.add_token(0, 'black') }.to output("Column number 0 is full, please play in another column\n").to_stdout
    end
  end

  describe '#column_is_full?' do
    before do
      # Completely fill column 0, partially fill column 3
      game_board.instance_variable_get(:@grid)[0][0] = 'black'
      game_board.instance_variable_get(:@grid)[1][0] = 'red'
      game_board.instance_variable_get(:@grid)[2][0] = 'black'
      game_board.instance_variable_get(:@grid)[3][0] = 'red'
      game_board.instance_variable_get(:@grid)[4][0] = 'black'
      game_board.instance_variable_get(:@grid)[5][0] = 'red'

      game_board.instance_variable_get(:@grid)[0][3] = 'black'
      game_board.instance_variable_get(:@grid)[1][3] = 'red'
    end

    it 'Returns true when there are 6 tokens in the column' do
      expect(game_board.column_is_full?(0)).to be true
    end

    it 'Returns false when there are no tokens in the column' do
      expect(game_board.column_is_full?(5)).to be false
    end

    it 'Returns false when there are 2 tokens in the column' do
      expect(game_board.column_is_full?(3)).to be false
    end
  end
end
