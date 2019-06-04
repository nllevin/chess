require "colorize"

class Piece
    attr_reader :color
    attr_accessor :pos, :board

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

    def empty?
        symbol == :null_piece
    end

    def valid_moves
        moves.reject { |move| move_into_check?(move) }
    end

    def moves
        #overwritten by subclasses
    end

    def symbol
        #overwritten by subclasses
    end

    def inspect
        "Symbol => #{symbol}, color => #{@color}, position => #{@pos}"
    end

    private

    def move_into_check?(end_pos)
        duped_board = @board.dup
        duped_board.move_piece!(@pos, end_pos)
        duped_board.in_check?(@color)
    end
end