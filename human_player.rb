require_relative "display"

class HumanPlayer
    def initialize(color, display)
        @color, @display = color, display
    end

    def make_move(board)
        cursor = @display.cursor
        start_pos = get_pos(cursor)

        if board[start_pos].color != @color
            cursor.toggle_selected
            @display.render
            print "It's #{@color}'s turn: "
            raise NotYourPieceError 
        end
        
        end_pos = get_pos(cursor)
        board.move_piece(start_pos, end_pos)

        rescue => e
            puts e.message
            make_move(board)
    end

    private

    def get_pos(cursor)
        pos = nil
        while pos.nil?
            pos = cursor.get_input
            @display.render
        end
        pos
    end
end

class NotYourPieceError < StandardError
    def message
        "you must move one of your own pieces."
    end
end