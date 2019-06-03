require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "pawn"
require_relative "null_piece"
require 'byebug'

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
        if piece.empty?
            raise NoPieceError
        elsif !piece.moves.include?(end_pos)
            raise InvalidMoveError
        elsif !piece.valid_moves.include?(end_pos)
            raise MoveIntoCheckError
        else
            piece.pos = end_pos
            self[start_pos], self[end_pos] = NullPiece.instance, piece
        end
    end

    def move_piece!(start_pos, end_pos)
        self[start_pos], self[end_pos] = NullPiece.instance, self[start_pos]
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

    def checkmate?(color)
        in_check?(color) && pieces.none? { |piece| piece.color == color && !piece.valid_moves.empty? }
    end

    def in_check?(color)
        king_pos = find_king(color).pos
        enemy_pieces = pieces.select { |piece| piece.color != color }
        enemy_pieces.any? { |enemy| enemy.moves.include?(king_pos) }
    end

    def find_king(color)
        pieces.find { |piece| piece.symbol == :king && piece.color == color }
    end

    def pieces
        piece_arr = []
        @rows.each do |row|
            piece_arr += row.reject { |tile| tile.empty? }
        end
        piece_arr
    end

    def dup
        duped_board = Board.new
        
        @rows.each_with_index do |row, row_idx|
            row.each_with_index do |tile, col_idx|
                tile_pos = [row_idx, col_idx]        
                piece_info = [tile.color, duped_board, tile_pos]
                case tile.symbol
                when :rook
                    duped_board[tile_pos] = Rook.new(*piece_info)
                when :knight
                    duped_board[tile_pos] = Knight.new(*piece_info)
                when :bishop
                    duped_board[tile_pos] = Bishop.new(*piece_info)
                when :queen
                    duped_board[tile_pos] = Queen.new(*piece_info)
                when :king
                    duped_board[tile_pos] = King.new(*piece_info)
                when :pawn
                    duped_board[tile_pos] = Pawn.new(*piece_info)
                when :null_piece
                    duped_board[tile_pos] = NullPiece.instance
                end
            end
        end
        duped_board
    end
end

class NoPieceError < StandardError
    def message
        "There is no piece to move from that start position."
    end
end

class InvalidMoveError < StandardError
    def message
        "That piece cannot move to that position."
    end
end

class MoveIntoCheckError < StandardError
    def message
        "You cannot move into check."
    end
end
