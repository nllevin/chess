require_relative "board"
require "colorize"

class Piece
    attr_reader :pos, :color

    def initialize(color, board, pos)
        @color, @board, @pos =
            color, board, pos
    end

    def to_s
        case symbol
        when :rook
            str = "R"
        when :knight
            str = "H"
        when :bishop
            str = "B"
        when :king
            str = "K"
        when :queen
            str = "Q"
        when :pawn
            str = "P"
        when :null_piece
            str = " "
        end

        case color
        when :white
            str = str.white
        when :black
            str = str.black
        end

        str
    end

    def moves
        #overwritten by subclasses
    end

    def valid_move?(end_pos)
        true
    end
end