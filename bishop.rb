require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable

    def symbol
        :bishop
    end

    protected

    def mov_dirs
        [:diagonal]
    end
end