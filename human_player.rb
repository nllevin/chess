require_relative "display"

class HumanPlayer
    def initialize(color, display)
        @color, @display = color, display
    end

    def make_move(board)
        cursor = @display.cursor

        start_pos = get_pos(cursor)
        raise NoPieceError if board[start_pos].empty?
        raise NotYourPieceError if board[start_pos].color != @color
        
        end_pos = get_pos(cursor)
        raise NoMoveError if start_pos == end_pos

        board.move_piece(start_pos, end_pos)

        rescue => e
            if e.is_a?(NotYourPieceError) || e.is_a?(NoPieceError)
                cursor.toggle_selected
                @display.render
                print "It's #{@color}'s turn: " if e.is_a?(NotYourPieceError)
            end
            puts e.message unless e.is_a?(NoMoveError)
            retry
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

class NoMoveError < StandardError
end