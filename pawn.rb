require_relative "piece"
require_relative "board"

class Pawn < Piece
    def symbol
        :pawn
    end

    def moves
        forward_steps #+ side_attacks
    end

    private

    def at_start_row?
        (@color == :white && @pos[0] == 6) ||
            (@color == :black && @pos[0] == 1)
    end

    def forward_dir
        @color == :white ? -1 : 1
    end

    def forward_steps
        forward_moves = []
        first_step = [@pos[0] + forward_dir, @pos[1]]
        if @board.valid_pos?(first_step) && @board[first_step].nil?                                  #change to null piece
            forward_moves << first_step

            second_step = [first_step[0] + forward_dir, first_step[1]]
            forward_moves << second_step if at_start_row? && @board[second_step].nil? && @board.valid_pos?(second_step) #change to null piece
        end
        forward_moves
    end
end