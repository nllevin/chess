require "colorize"
require "byebug"
require_relative "board"
require_relative "cursor"

class Display
    attr_reader :cursor, :board
    
    def initialize(board, debug)
        @board, @cursor, @debug = 
            board, Cursor.new([0,0], board), debug
    end

    def render
        system("clear")
        @board.rows.each_with_index do |row, row_idx|
            print "#{8 - row_idx} "
            row.each_with_index do |piece, col_idx|
                piece_str = piece.to_s
                if @cursor.cursor_pos == [row_idx, col_idx]
                    if @cursor.selected
                        print piece_str.on_red
                    else
                        print piece_str.on_light_blue
                    end
                elsif (row_idx + col_idx).even?
                    print piece_str.on_white
                else
                    print piece_str.on_light_black
                end
            end
            puts
        end
        puts "  #{("a".."h").to_a.join("")}"
        
        if @debug
            puts "White in check: #{@board.in_check?(:white)}"
            puts "Black in check: #{@board.in_check?(:black)}"
            print @board[@cursor.cursor_pos].moves if @cursor.selected
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    test_display = Display.new(Board.new, true)
    while true
        test_display.render
        test_display.cursor.get_input
    end
end