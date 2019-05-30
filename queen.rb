require_relative "piece"
require_relative "slideable"

class Queen < Piece
    include Slideable

    def symbol
        :queen
    end

    protected

    def mov_dirs
        [:horizontal, :diagonal]
    end
end