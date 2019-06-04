require_relative "display"
require_relative "human_player"

class Game
    attr_reader :current_player

    def initialize
        @board = Board.new
        @display = Display.new(@board, false)
        @players = { 
            :white => HumanPlayer.new(:white, @display), 
            :black => HumanPlayer.new(:black, @display) 
        }
        @current_player = :white 
    end

    def play
        until @board.checkmate?(:white) || @board.checkmate?(:black)
            @players[@current_player].make_move(@board)
            swap_turn!
        end
        @display.render
    end

    private

    def swap_turn!
        @current_player = @players.keys.find { |player| player != @current_player }
    end
end