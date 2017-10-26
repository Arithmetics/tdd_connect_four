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
      #if a piece was playable
      if lowest.location[1] < 99
        #place piece
        @cells[@cells.find_index(lowest)].contents = color
        check = @cells[@cells.find_index(lowest)].contents
        #change the turn
        if @turn == "black"
          @turn = "red"
        else
          @turn = "black"
        end
        #check win conditions relative to that place piece

      end
    end
  end

  def black_win?
    #horizontal wins first
    win = false
    @cells.each do |cell|
      #horizontal wins
      next_three = @cells.find_all do |adj_cell|
                     adj_cell.location[0] > cell.location[0] &&
                     adj_cell.location[0] < (cell.location[0] + 4) &&
                     adj_cell.location[1] == cell.location[1] &&
                     adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "black"}
        win = true
      end
      #vertical wins
      next_three = @cells.find_all do |adj_cell|
                     adj_cell.location[1] > cell.location[1] &&
                     adj_cell.location[1] < (cell.location[1] + 4) &&
                     adj_cell.location[0] == cell.location[0] &&
                     adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "black"}
        win = true
      end
      #upwards diagonal wins
      next_three = @cells.find_all do |adj_cell|
                     (  adj_cell.location[0] == (cell.location[0] + 1) &&
                        adj_cell.location[1] == (cell.location[1] + 1) ||
                        adj_cell.location[0] == (cell.location[0] + 2) &&
                        adj_cell.location[1] == (cell.location[1] + 2) ||
                        adj_cell.location[0] == (cell.location[0] + 3) &&
                        adj_cell.location[1] == (cell.location[1] + 3)
                      ) && adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "black"}
        win = true
      end
      #downwards diagonal wins
      next_three = @cells.find_all do |adj_cell|
                     (  adj_cell.location[0] == (cell.location[0] + 1) &&
                        adj_cell.location[1] == (cell.location[1] - 1) ||
                        adj_cell.location[0] == (cell.location[0] + 2) &&
                        adj_cell.location[1] == (cell.location[1] - 2) ||
                        adj_cell.location[0] == (cell.location[0] + 3) &&
                        adj_cell.location[1] == (cell.location[1] - 3)
                      ) && adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "black"}
        win = true
      end
    end
    win
  end

  def red_win?
    #horizontal wins first
    win = false
    @cells.each do |cell|
      #horizontal wins
      next_three = @cells.find_all do |adj_cell|
                     adj_cell.location[0] > cell.location[0] &&
                     adj_cell.location[0] < (cell.location[0] + 4) &&
                     adj_cell.location[1] == cell.location[1] &&
                     adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "red"}
        win = true
      end
      #vertical wins
      next_three = @cells.find_all do |adj_cell|
                     adj_cell.location[1] > cell.location[1] &&
                     adj_cell.location[1] < (cell.location[1] + 4) &&
                     adj_cell.location[0] == cell.location[0] &&
                     adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "red"}
        win = true
      end
      #upwards diagonal wins
      next_three = @cells.find_all do |adj_cell|
                     (  adj_cell.location[0] == (cell.location[0] + 1) &&
                        adj_cell.location[1] == (cell.location[1] + 1) ||
                        adj_cell.location[0] == (cell.location[0] + 2) &&
                        adj_cell.location[1] == (cell.location[1] + 2) ||
                        adj_cell.location[0] == (cell.location[0] + 3) &&
                        adj_cell.location[1] == (cell.location[1] + 3)
                      ) && adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "red"}
        win = true
      end
      #downwards diagonal wins
      next_three = @cells.find_all do |adj_cell|
                     (  adj_cell.location[0] == (cell.location[0] + 1) &&
                        adj_cell.location[1] == (cell.location[1] - 1) ||
                        adj_cell.location[0] == (cell.location[0] + 2) &&
                        adj_cell.location[1] == (cell.location[1] - 2) ||
                        adj_cell.location[0] == (cell.location[0] + 3) &&
                        adj_cell.location[1] == (cell.location[1] - 3)
                      ) && adj_cell.contents == cell.contents
                   end
      if next_three.length == 3 && next_three.all? {|cell| cell.contents == "red"}
        win = true
      end
    end
    win
  end

  def tie?
    if !black_win? && !red_win?
      @cells.all? {|cell| cell.contents != nil}
    end
  end

  def play
    until black_win? || red_win? || tie?
      if turn == "black"
        draw
        puts 'black turn: what column do you want to put your piece in?'
        placement = gets.chomp.to_i
        play_piece(placement, "black")
      else
        draw
        puts 'red turn: what column do you want to put your piece in?'
        placement = gets.chomp.to_i
        play_piece(placement, "red")
      end
    end

    if black_win?
      draw
      puts "black wins"
    elsif red_win?
      draw
      puts "red wins"
    else
      draw
      puts "tie!"
    end
  end

  def draw
    drawings = []
    @cells.each do |cell|
      if cell.contents == nil
        drawings.push(" ")
      elsif cell.contents == "black"
        drawings.push("\u{2688}")
      elsif cell.contents == "red"
        drawings.push("\u{2686}")
      end
    end
    puts " ___________________________"
    puts "| #{drawings[5]} | #{drawings[11]} | #{drawings[17]} | #{drawings[23]} | #{drawings[29]} | #{drawings[35]} | #{drawings[41]} | 5"
    puts "|___|___|___|___|___|___|___|_"
    puts "| #{drawings[4]} | #{drawings[10]} | #{drawings[16]} | #{drawings[22]} | #{drawings[28]} | #{drawings[34]} | #{drawings[40]} | 4"
    puts "|___|___|___|___|___|___|___|_"
    puts "| #{drawings[3]} | #{drawings[9]} | #{drawings[15]} | #{drawings[21]} | #{drawings[27]} | #{drawings[33]} | #{drawings[39]} | 3"
    puts "|___|___|___|___|___|___|___|_"
    puts "| #{drawings[2]} | #{drawings[8]} | #{drawings[14]} | #{drawings[20]} | #{drawings[26]} | #{drawings[32]} | #{drawings[38]} | 2"
    puts "|___|___|___|___|___|___|___|_"
    puts "| #{drawings[1]} | #{drawings[7]} | #{drawings[13]} | #{drawings[19]} | #{drawings[25]} | #{drawings[31]} | #{drawings[37]} | 1"
    puts "|___|___|___|___|___|___|___|_"
    puts "| #{drawings[0]} | #{drawings[6]} | #{drawings[12]} | #{drawings[18]} | #{drawings[24]} | #{drawings[30]} | #{drawings[36]} | 0"
    puts "|___|___|___|___|___|___|___|_"
    puts "| 0 | 1 | 2 | 3 | 4 | 5 | 6 |"
  end

end



class Cell
  attr_accessor :location, :contents

  def initialize(x,y)
    @location = [x,y]
    @contents = nil
  end
end
