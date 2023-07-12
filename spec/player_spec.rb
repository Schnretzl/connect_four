require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new('Wes', 'blue') }
  let(:game_board) { double('Board') }

  describe '#play' do
    it 'Sends a message to the board to add a token' do
      expect(game_board).to receive(:add_token)
      player.play(game_board, 4)
    end
  end
end