module ToyRobot
  ALLOWED_COMMANDS = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
  ALLOWED_DIRECTIONS = ["NORTH", "SOUTH", "EAST", "WEST"]
  BOARD = { x_dim: 5, y_dim: 5 }
  MOVING = {
    "RIGHT": {
      "NORTH": "EAST",
      "EAST": "SOUTH",
      "SOUTH": "WEST",
      "WEST": "NORTH"
    }, 
    "LEFT": {
      "NORTH": "WEST",
      "WEST": "SOUTH",
      "SOUTH": "EAST",
      "EAST": "NORTH" 
    }
  }

  class Rover
    def initialize(input)
      @is_on_the_table = false
      @commands = input
      @position = {}
      @backtracking = []
    end

    def go!
      @commands.each do |cmd|
        # traversing over the board ignoring strange commands if given
        traverse cmd if ALLOWED_COMMANDS.include? cmd.split(' ').first
        @backtracking << spy
      end
    end

    def is_on_the_table?
      @is_on_the_table
    end
 
    def report!
      "#{@position[:x]},#{@position[:y]},#{@direction_to_move}"
    end

    def to_s
      "Robot at (#{@position[:x]},#{@position[:y]}) moving to #{@direction_to_move}"
    end

    def spy
      [@position, @direction_to_move]
    end

    def show_the_path
      @backtracking
    end

    private

    def traverse(cmd)
      if !is_on_the_table? || cmd.match?(/\APLACE\s\d,\d,\w{4,5}\z/) 
        
        co = cmd.split(' ').last

        return unless good_to_start? co

        x, y, f = co.split(',')

        return place_on_board(x: x.to_i, y: y.to_i, f: f)
      end

      return unless is_on_the_table? #JUST IGNORE IF NOT ON THE TABLE!

      return rotate cmd if cmd == "LEFT" || cmd == "RIGHT"  
      
      return go_ahead if cmd == "MOVE"
      
      return puts report! if cmd == "REPORT"
    end

    def good_to_start?(xyf)
      x, y, f = xyf.split(',')
      
      valid_place_command?(x.to_i, y.to_i) && valid_direction?(f)
    end

    def valid_direction?(f)
      ALLOWED_DIRECTIONS.include? f
    end

    def valid_place_command?(x, y)
      (x < BOARD[:x_dim] && x >= 0) && (y < BOARD[:y_dim] && y >= 0)
    end

    def rotate(direction)
      @direction_to_move = MOVING[direction.to_sym][@direction_to_move.to_sym].to_s
    end

    def place_on_board(x:, y:, f:)
      @position[:x] = x
      @position[:y] = y

      @direction_to_move = f
      
      @is_on_the_table = true
    end

    def go_ahead
      x, y = @position[:x], @position[:y]

      x -= 1 if @direction_to_move == "WEST"
      x += 1 if @direction_to_move == "EAST"
      y -= 1 if @direction_to_move == "NORTH"
      y += 1 if @direction_to_move == "SOUTH"

      if valid_place_command? x, y
        @position[:x] = x
        @position[:y] = y
      end
    end
  end
end