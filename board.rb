require_relative "piece"

class Board
    attr_reader :rows

    def initialize
        @rows = Array.new(8) { [] }
        @rows.each_with_index do |row, row_idx|
            if [0,1,6,7].include?(row_idx)
                #8.times { row << Piece.new }
            else
                #8.times { row << nil }
            end
        end
    end

    def move_piece(start_pos, end_pos)
        piece = self[start_pos]
        if piece.nil?
            raise NoPieceError
        elsif !piece.valid_move?(end_pos)
            raise InvalidMoveError
        else
            self[start_pos], self[end_pos] = nil, piece
        end
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @rows[row][col] = piece
    end

    def valid_pos?(pos)
        row, col = pos
        row.between?(0,7) && col.between?(0,7)
    end
end

class NoPieceError < StandardError
    def message
        "There is no piece to move from that start position."
    end
end

class InvalidMoveError < StandardError
    def message
        "That piece cannot move to that end position."
    end
end
