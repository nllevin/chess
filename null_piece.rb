require "singleton"

class NullPiece
    include Singleton
    
    def initialize
    end

    def moves
    end
    
    def symbol
        :null_piece
    end
end