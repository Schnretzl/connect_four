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
      # Completely fill column 0, 
      game_board.instance_variable_get(:@grid)[0][0] = 'black'
      game_board.instance_variable_get(:@grid)[1][0] = 'red'
      game_board.instance_variable_get(:@grid)[2][0] = 'black'
      game_board.instance_variable_get(:@grid)[3][0] = 'red'
      game_board.instance_variable_get(:@grid)[4][0] = 'black'
      game_board.instance_variable_get(:@grid)[5][0] = 'red'
      # Partially fill column 3
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

  describe '#winner?' do
    it 'Runs column_winner?' do
      expect(game_board).to receive(:column_winner?)
      game_board.winner?
    end
    it 'Runs row_winner?' do
      expect(game_board).to receive(:row_winner?)
      game_board.winner?
    end
    it 'Runs diagonal_winner?' do
      expect(game_board). to receive(:diagonal_winner?)
      game_board.winner?
    end
  end

  context 'Checking columns' do
    describe '#column_winner?' do
      before do
        game_board.instance_variable_get(:@grid)[0][0] = 'black'
        game_board.instance_variable_get(:@grid)[1][0] = 'black'
        game_board.instance_variable_get(:@grid)[2][0] = 'black'
      end
      it 'Returns false when there are only 3 in a row on the first column' do
        expect(game_board.winner?).to be false
      end
      it 'Returns false when there is a winner in a row, but not a column' do
        game_board.instance_variable_get(:@grid)[0][1] = 'black'
        game_board.instance_variable_get(:@grid)[0][2] = 'black'
        game_board.instance_variable_get(:@grid)[0][3] = 'black'
      end
      it 'Returns true when there is 4 in a row on the first column' do
        game_board.instance_variable_get(:@grid)[3][0] = 'black'
        expect(game_board.winner?).to be true
      end
    end
  end

  context 'Checking rows' do
    describe '#row_winner?' do
      before do
        game_board.instance_variable_get(:@grid)[0][0] = 'black'
        game_board.instance_variable_get(:@grid)[0][1] = 'black'
        game_board.instance_variable_get(:@grid)[0][2] = 'black'
      end
      it 'Returns false when there are only 3 in a row on the first row' do
        expect(game_board.winner?).to be false
      end
      it 'Returns false when there is a winner in a column, but not a row' do
        game_board.instance_variable_get(:@grid)[1][0] = 'black'
        game_board.instance_variable_get(:@grid)[2][0] = 'black'
        game_board.instance_variable_get(:@grid)[3][0] = 'black'
      end
      it 'Returns true when there is 4 in a row on the first row' do
        game_board.instance_variable_get(:@grid)[0][3] = 'black'
        expect(game_board.winner?).to be true
      end
    end
  end

  context 'Checking diagonals' do
    describe '#diagonal_winner?' do
      context 'Going from down-left to up-right' do
        before do
          game_board.instance_variable_get(:@grid)[0][0] = 'black'
          game_board.instance_variable_get(:@grid)[1][1] = 'black'
          game_board.instance_variable_get(:@grid)[2][2] = 'black'
        end
        it 'Returns false when there are only 3 in a row diagonally' do
          expect(game_board.winner?).to be false
        end
        it 'Returns true when there are 4 in a row diagonally' do
          game_board.instance_variable_get(:@grid)[3][3] = 'black'
          expect(game_board.winner?).to be true
        end
      end
      context 'Going from down-right to up-left' do
        before do
          game_board.instance_variable_get(:@grid)[0][6] = 'black'
          game_board.instance_variable_get(:@grid)[1][5] = 'black'
          game_board.instance_variable_get(:@grid)[2][4] = 'black'
        end
        it 'Returns false when there are only 3 in a row diagonally' do
          expect(game_board.winner?).to be false
        end
        it 'Returns true when there are 4 in a row diagonally' do
          game_board.instance_variable_get(:@grid)[3][3] = 'black'
          expect(game_board.winner?).to be true
        end
      end
    end
  end

  describe '#print_board' do
    it 'Outputs 6 lines of text' do
      expect(game_board.print_board).to receive(:puts).exactly(6).times
    end
  end
end
