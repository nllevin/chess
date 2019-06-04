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
            @display.render
            notify_players
            @players[@current_player].make_move(@board)
            swap_turn!
        end
        @display.render
    end

    private

    def notify_players
        puts "It's your turn, #{@current_player.to_s} player."
    end

    def swap_turn!
        @current_player = @players.keys.find { |player| player != @current_player }
    end
end

if __FILE__ == $PROGRAM_NAME
    Game.new.play
end