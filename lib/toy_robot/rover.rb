module ToyRobot
  class Rover
    ALLOWED_COMMANDS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
    ALLOWED_DIRECTIONS = ["NORTH", "SOUTH", "EAST", "WEST"]
    BOARD = { x_dim: 5, y_dim: 5 }
    MOVING = {
      "LEFT": {
        "NORTH": "EAST",
        "EAST": "SOUTH",
        "SOUTH": "WEST",
        "WEST": "NORTH"
      }, 
      "RIGHT": {
        "NORTH": "WEST",
        "WEST": "SOUTH",
        "SOUTH": "EAST",
        "EAST": "NORTH" 
      }
    }

    attr_accessor :position, :direction_to_move
    attr_reader :commands, :is_on_the_table

    def initialize(input)
      @is_on_the_table = false
      @commands = input
      @position = {}
    end

    def do_the_thing
      # go back if there are nothing to do!
      raise "GiveValidCommandsFirst" unless @commands

      @commands.each do |cmd|
        # traversing over the board ignoring strange commands if given
        traverse cmd if ALLOWED_COMMANDS.include? cmd.split(' ').first
      end
    end

    def traverse(cmd)
      if !@is_on_the_table || cmd.match?(/\APLACE\s\d,\d,\w{4,5}\z/) 
        
        co = cmd.split(' ').last

        return unless good_to_start? co

        place_on_board co.split(',')
        
        return
      end

      return unless @is_on_the_table #JUST IGNORE IF NOT ON THE TABLE!

      if cmd == "LEFT" || cmd == "RIGHT"  
        rotate cmd
      end
      
      if cmd == "MOVE"
        recalculate_position
        puts "moving to #{@position} and looking to #{@direction_to_move}"
      end
      
      if cmd == "REPORT"
        puts report 
      end
    end

    def good_to_start?(xyf)
      x, y, f = xyf.split(',')
      
      valid_place_command?(x.to_i, y.to_i) && valid_direction?(f)
    end

    def valid_direction?(f)
      ALLOWED_DIRECTIONS.include? f
    end

    def report
      "#{@position[:x]},#{@position[:y]},#{@direction_to_move}"
    end

    def is_on_the_table?
      @is_on_the_table
    end

    private

    def still_on_board?
      valid_place_command? @position[:x], @position[:y]
    end

    def valid_place_command?(x, y)
      (x < BOARD[:x_dim] && x >= 0) && (y < BOARD[:y_dim] && y >= 0)
    end

    def rotate(direction)
      @direction_to_move = MOVING[direction.to_sym][@direction_to_move.to_sym].to_s
    end

    # SMELLS here, it's C style, not ruby style
    def place_on_board(directions)
      @position[:x] = directions[0].to_i
      @position[:y] = directions[1].to_i
      @direction_to_move = directions[2]
      @is_on_the_table = true
    end

    def recalculate_position
      crtasaos = @position # dry-run

      crtasaos[:x] -= 1 if @direction_to_move == "WEST"
      crtasaos[:x] += 1 if @direction_to_move == "EAST"
      crtasaos[:y] -= 1 if @direction_to_move == "NORTH"
      crtasaos[:y] += 1 if @direction_to_move == "SOUTH"

      @position = crtasaos if valid_place_command? crtasaos[:x], crtasaos[:y]
    end
  end
end