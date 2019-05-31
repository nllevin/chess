require_relative "piece"
require_relative "board"

class Pawn < Piece
    def symbol
        :pawn
    end

    def moves
        forward_steps + side_attacks
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
        if @board.valid_pos?(first_step) && @board[first_step].empty?                                  
            forward_moves << first_step

            second_step = [first_step[0] + forward_dir, first_step[1]]
            forward_moves << second_step if at_start_row? && @board[second_step].empty? && @board.valid_pos?(second_step)
        end
        forward_moves
    end

    def side_attacks
        [[@pos[0] + forward_dir, @pos[1] - 1], [@pos[0] + forward_dir, @pos[1] + 1]].select do |potential_move|
            @board.valid_pos?(potential_move) && !@board[potential_move].empty? && @board[potential_move].color != self.color
        end
    end
end