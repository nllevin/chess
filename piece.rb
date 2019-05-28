require_relative "board"

class Piece
    

    def initialize(pos, color, board)
        @pos, @color, @board =
            pos, color, board
    end

    def moves

    end

    def valid_move?(end_pos)
        true
    end
end