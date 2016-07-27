# Maintains game board state
class Board
    # initialize board
    def initialize
        # set up blank data structure
        @board = Array.new(10){Array.new(10)}
    end

    # render
    def render
        puts
        # loop through data structure
        @board.each do |row|
            row.each do |cell|
                # display an existing marker if any, else blank
                cell.nil? ? print("+".center(2)) : print(cell.to_s.center(2))
            end
            puts
        end
        puts

    end

    # add_piece
    def add_piece(coords, piece)
        # IF piece_location_valid?
        if piece_location_valid?(coords)
            # place piece
            @board[coords[0]][coords[1]] = piece
            true
        else
            false
        end
    end

    # piece_location_valid?
    def piece_location_valid?(coords)
        # Is the placement within_valid_coordinates?
        if within_valid_coordinates?(coords)
            # Are the piece coordinates_available?
            coordinates_available?(coords)
        end
    end

    # within_valid_coordinates?
    def within_valid_coordinates?(coords)
        # UNLESS piece coords are in the acceptible range
        if (0..9).include?(coords[0]) && (0..9).include?(coords[1])
            true
        else
            # display an error message
            puts "Piece coordinates are out of bounds"
        end
    end

    # coordinates_available?
    def coordinates_available?(coords)
        # UNLESS piece coords are not occupied
        if @board[coords[0]][coords[1]].nil?
            true
        else
            # display error message
            puts "There is already a piece there!"
        end
    end

    # winning_combination?
    def winning_combination?(piece)
        # is there a winning_diagonal?
        # or winning_vertical?
        # or winning_horizontal? for that piece?
        # winning_diagonal?(piece)   ||
        winning_horizontal?(piece) ||
        winning_vertical?(piece)
    end

    # winning_diagonal?
    def winning_diagonal?(piece)
        # check if specified piece has a triplet across diagonals
        diagonals.any? do |diag|
            diag.all?{|cell| cell == piece }
        end
    end

    # winning_vertical?
    def winning_vertical?(piece)
        # check if specified piece has a triplet across verticals
        verticals.any? do |vert|
            vert.all?{|cell| cell == piece }
        end
    end

    # winning_horizontal?
    def winning_horizontal?(piece)
        # check if specified piece has a triplet across horizontals
        horizontals.any? do |horz|
            horz.all?{|cell| cell == piece }
        end
    end

    # diagonals
    def diagonals
        # return the diagonal pieces
        [[ @board[0][0],@board[1][1],@board[2][2] ],[ @board[2][0],@board[1][1],@board[0][2] ]]
    end

    # verticals
    def horizontals
        # return the vertical pieces
        array_transform @board
    end

    # horizontals
    def verticals
        # return the horizontal pieces
        verts = []
        10.times do |i|
            verts << [@board[0][i],@board[1][i],@board[2][i],@board[3][i],@board[4][i],@board[5][i],@board[6][i],@board[7][i],@board[8][i],@board[9][i]]
        end
        array_transform verts
    end

    def array_transform array
      result = []
      array.each do |row|
        5.times do |start_point|
          result << row[start_point..(start_point + 4)]
        end
      end
      result
    end

    # full?
    def full?
        # does every square contain a piece?
        @board.all? do |row|
            row.none?(&:nil?)
        end
    end

end
