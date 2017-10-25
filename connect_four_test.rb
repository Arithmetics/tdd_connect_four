require 'minitest/autorun'
require_relative 'connect_four'


class CFGameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_all_cells_created
    assert @game.cells.length == 42
    @game.cells.all? {|x| assert_kind_of Cell, x}
  end

  def test_place_piece_in_correct_cell
    #start with empty board, play in column 4
    @game.play_piece(4, "black")
    #find cell that should be filled
    full_slot = @game.cells.find {|cell| cell.location == [4,0]}
    assert full_slot.contents == "black"

  end

  def test_place_piece_leaves_cell_above_empty
    #start with empty board, play in column 4
    @game.play_piece(4, "black")
    #find all cells in same column that should be empty
    empty_slots = @game.cells.find_all do |cell|
      cell.location[0] == 4 && cell.location[1] > 0
    end
    empty_slots.each do |cell|
      assert cell.contents == nil
    end
  end

  def test_subsequent_piece_goes_above_and_not_over_write
    #start with empty board, play in column 4
    @game.play_piece(4, "black")
    #then, play another piece in column 4
    @game.play_piece(4, "red")
    #find cell that should be filled with black
    full_slot = @game.cells.find {|cell| cell.location == [4,0]}
    assert full_slot.contents == "black"
    full_slot = @game.cells.find {|cell| cell.location == [4,1]}
    assert full_slot.contents == "red"
  end

  def test_swaps_turn_on_successful_play
    @game.play_piece(4, "black")
    assert @game.turn == "red"
  end

  def test_doesnt_swap_turn_on_bad_play
    #non existent column
    @game.play_piece(20, "black")
    assert @game.turn == "black"
    #full column
    @game.play_piece(4, "black")
    @game.play_piece(4, "red")
    @game.play_piece(4, "black")
    @game.play_piece(4, "red")
    @game.play_piece(4, "black")
    @game.play_piece(4, "red")
    #illegal move
    @game.play_piece(4, "black")
    assert @game.turn == "black"
  end


end


class WinTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_basic_horizonal_win
    @game.play_piece(0, "black")
    @game.play_piece(1, "black")
    @game.play_piece(2, "black")
    refute @game.black_win?
    @game.play_piece(3, "black")
    assert @game.black_win?
  end

  def test_basic_vertical_win
    @game.play_piece(0, "black")
    @game.play_piece(0, "black")
    @game.play_piece(0, "black")
    refute @game.black_win?
    @game.play_piece(0, "black")
    assert @game.black_win?
  end

  def test_basic_diagonal_win
    @game.play_piece(3, "red")
    @game.play_piece(4, "black")
    @game.play_piece(5, "red")
    @game.play_piece(6, "black")
    @game.play_piece(4, "red")
    @game.play_piece(5, "black")
    @game.play_piece(6, "red")
    @game.play_piece(5, "red")
    @game.play_piece(6, "black")
    refute @game.red_win?
    @game.play_piece(6, "black")
    assert @game.red_win?
  end

  def test_no_win_if_interrupted
    @game.play_piece(0, "black")
    @game.play_piece(1, "black")
    @game.play_piece(2, "black")
    @game.play_piece(3, "red")
    refute @game.black_win?
    @game.play_piece(4, "black")
    refute @game.black_win?
  end



end


class CFCellTest < Minitest::Test

  def test_cell_created
    x = Cell.new(2,2)
    assert x.location == [2,2]
    assert x.contents == nil
  end

end
