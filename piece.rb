require "colorize"

class Piece
    attr_reader :color
    attr_accessor :pos, :board

    def initialize(color, board, pos)
        @color, @board, @pos =
            color, board, pos
    end

    def to_s
        case color
        when :white
            case symbol
            when :rook
                str = "\u2656"
            when :knight
                str = "\u2658"
            when :bishop
                str = "\u2657"
            when :king
                str = "\u2654"
            when :queen
                str = "\u2655"
            when :pawn
                str = "\u2659"
            end
        when :black
            case symbol
            when :rook
                str = "\u265C"
            when :knight
                str = "\u265E"
            when :bishop
                str = "\u265D"
            when :king
                str = "\u265A"
            when :queen
                str = "\u265B"
            when :pawn
                str = "\u265F"
            end
        else 
            str = " "
        end

        str.black
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