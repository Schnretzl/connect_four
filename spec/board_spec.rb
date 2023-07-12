require_relative '../lib/board'

describe Board do
  let(:player1) { double('Player') }
  let(:player2) { double('Player') }
  subject(:game_board) { described_class.new(player1, player2) }

  describe '#add_token' do
    it 'Adds a black token to column 0' do
      grid = game_board.instance_variable_get(:@grid)
      game_board.add_token(0, 'black')
      expect(grid[0][0]).to eq 'black'
    end
  end
end