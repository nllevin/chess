require_relative "display"

class HumanPlayer
    def initialize(color, display)
        @color, @display = color, display
    end

    def make_move(board)
        cursor = @display.cursor
        start_pos = nil
        while start_pos.nil?
            @display.render
            start_pos = cursor.get_input
        end
        end_pos = nil
        while end_pos.nil?
            @display.render
            end_pos = cursor.get_input
        end
        board.move_piece(start_pos, end_pos)
    end
end