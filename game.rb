require_relative "display"

class Game
    def initialize
        @board = Board.new
        @display = Display.new(@board, false)
        @players = { :white => HumanPlayer.new, :black => HumanPlayer.new }
        @current_player = :white 
    end
end