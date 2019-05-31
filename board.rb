require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "pawn"
require_relative "null_piece"

class Board
    attr_reader :rows

    def initialize
        @rows = Array.new(8) { [] }
        @rows.each_with_index do |row, row_idx|
            case row_idx
            when 0, 7
                color = (row_idx == 0 ? :black : :white)
                (0..7).each do |col_idx|
                    piece_info = [color, self, [row_idx, col_idx]]
                    case col_idx
                    when 0, 7
                        row << Rook.new(*piece_info)
                    when 1, 6
                        row << Knight.new(*piece_info)
                    when 2, 5
                        row << Bishop.new(*piece_info)
                    when 3
                        row << Queen.new(*piece_info)
                    when 4
                        row << King.new(*piece_info)
                    end
                end
            when 1, 6
                color = (row_idx == 1 ? :black : :white)
                (0..7).each do |col_idx|
                    piece_info = [color, self, [row_idx, col_idx]]
                    row << Pawn.new(*piece_info)
                end
            else
                8.times { row << NullPiece.instance }
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
