require_relative "board"

class Piece
    

    def initialize(color, board, pos)
        @color, @board, @pos =
            color, board, pos
    end

    def moves

    end

    def valid_move?(end_pos)
        true
    end
end