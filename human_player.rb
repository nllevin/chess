require_relative "display"

class HumanPlayer
    def initialize(color, display)
        @color, @display = color, display
    end

    def make_move(board)
        cursor = @display.cursor
        start_pos = nil
        while start_pos.nil?
            start_pos = cursor.get_input
            @display.render
        end

        if board[start_pos].color != @color
            cursor.toggle_selected
            @display.render
            print "It's #{@color}'s turn: "
            raise NotYourPieceError 
        end
        
        end_pos = nil
        while end_pos.nil?
            end_pos = cursor.get_input
            @display.render
        end
        board.move_piece(start_pos, end_pos)
        rescue => e
            puts e.message
            make_move(board)
    end
end

class NotYourPieceError < StandardError
    def message
        "you must move one of your own pieces."
    end
end