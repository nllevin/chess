module Slideable
    HORIZONTAL_DIRS = [
        :north,
        :south,
        :west,
        :east
    ]

    DIAGONAL_DIRS = [
        :northeast,
        :southeast,
        :southwest,
        :northwest
    ]

    def moves
        moves_arr = []
        dirs = self.move_dirs
        moves_arr += self.horizontal_dirs if dirs.include?(:horizontal)
        moves_arr += self.diagonal_dirs if dirs.include?(:diagonal)
        moves_arr
    end

    def horizontal_dirs
        horizontal_moves = []
        HORIZONTAL_DIRS.each do |horizontal_dir|
            case horizontal_dir
            when :north
                horizontal_moves += grow_unblocked_moves_in_dir(0,1)
            when :south
                horizontal_moves += grow_unblocked_moves_in_dir(0,-1)
            when :west
                horizontal_moves += grow_unblocked_moves_in_dir(-1,0)
            when :east
                horizontal_moves += grow_unblocked_moves_in_dir(1,0)
            end
        end
        horizontal_moves
    end
end