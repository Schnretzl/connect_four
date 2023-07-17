require_relative '../lib/game'

RSpec.describe '#input_valid_player_name' do
  subject(:name) { String.new }
  let(:player_number) { 1 }

  context 'when a valid name is entered' do
    it 'does not show an error message' do
      allow(STDIN).to receive(:gets).and_return('John')

      output = ""
      allow(STDOUT).to receive(:puts) { |message| output += message }

      input_valid_player_name(player_number)

      expect(output).not_to include('Invalid name entered, please enter only letters.')
    end
    it 'returns the entered name' do
      allow(STDIN).to receive(:gets).and_return('John')

      name = input_valid_player_name(player_number)
      expect(name).to eq('John')
    end
  end

  context 'when an invalid name is entered' do
    it 'prompts for a valid name' do
      allow(STDIN).to receive(:gets).and_return('123', 'John')

      output = ""
      allow(STDOUT).to receive(:puts) { |message| output += message }

      input_valid_player_name(player_number)

      expect(output).to include('Invalid name entered, please enter only letters.').once
    end
  end
end
