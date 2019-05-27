require "colorize"
require "byebug"
require_relative "board"
require_relative "cursor"

class Display
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        system("clear")
        @board.rows.each_with_index do |row, row_idx|
            print "#{8 - row_idx} "
            row.each_with_index do |tile, col_idx|
                tile_str = (tile.nil? ? " " : "P")
                if @cursor.cursor_pos == [row_idx, col_idx]
                    print tile_str.on_light_blue
                elsif (row_idx + col_idx).even?
                    print tile_str.black.on_white
                else
                    print tile_str.on_black
                end
            end
            puts
        end
        puts "  #{("a".."h").to_a.join("")}"
    end
end