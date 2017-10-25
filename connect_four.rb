#connect_four board game
#board is 7 slots wide by 6 slots high
#winning condition is 4 in a row up, down, and diagonal
#i think to check win, program should only check if new piece
  #that was added creates a winning condition

class Game
  attr_accessor :cells, :turn

  def initialize
    @turn = "black"
    @cells = []
    (0..6).each do |x|
      (0..5).each do |y|
        @cells.push(Cell.new(x,y))
      end
    end
  end

  def play_piece(column, color)
    lowest = Cell.new(99,99)
    chosen_column = @cells.find_all do |cell|
                      cell.location[0] == column && cell.contents == nil
                    end
    if chosen_column.length > 0
      chosen_column.each do |cell|
        if cell.location[1] < lowest.location[1]
          lowest = cell
        end
      end
      if lowest.location[1] < 99
        @cells[@cells.find_index(lowest)].contents = color
        if @turn == "black"
          @turn = "red"
        else
          @turn = "black"
        end
      end
    end
  end
  
end



class Cell
  attr_accessor :location, :contents

  def initialize(x,y)
    @location = [x,y]
    @contents = nil
  end
end
