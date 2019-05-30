require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable

    def symbol
        :bishop
    end

    protected

    def move_dirs
        [:diagonal]
    end
end