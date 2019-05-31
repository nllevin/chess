require_relative "board"

class Piece
    attr_reader :pos

    def initialize(color, board, pos)
        @color, @board, @pos =
            color, board, pos
    end

    def moves
        #overwritten by subclasses
    end

    def valid_move?(end_pos)
        true
    end
end