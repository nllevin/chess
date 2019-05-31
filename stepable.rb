module Stepable
    def moves
        moves_arr = []
        self.move_diffs.each do |move_diff|
            dx, dy = move_diff
            potential_move = [@pos[0] + dx, @pos[1] + dy]
            if @board.valid_pos?(potential_move)
                occupant = @board[potential_move]
                if occupant.empty? || occupant.color != self.color
                    moves_arr << [potential_move[0], potential_move[1]]
                end
            end
        end
        moves_arr
    end

    private

    def move_diffs
        #overwritten by subclass
    end
end