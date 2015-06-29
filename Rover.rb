=begin

A squad of robotic rovers are to be landed by NASA on a plateau on Mars.
This plateau, which is curiously rectangular, must be navigated by the
rovers so that their on-board cameras can get a complete view of the
surrounding terrain to send back to Earth.

A rover's position and location is represented by a combination of x and y
co-ordinates and a letter representing one of the four cardinal compass
points. The plateau is divided up into a grid to simplify navigation. An
example position might be 0, 0, N, which means the rover is in the bottom
left corner and facing North.

In order to control a rover, NASA sends a simple string of letters. The
possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90
degrees left or right respectively, without moving from its current spot.
'M' means move forward one grid point, and maintain the same heading.

Assume that the square directly North from (x, y) is (x, y+1).

INPUT:
The first line of input is the upper-right coordinates of the plateau, the
lower-left coordinates are assumed to be 0,0.

The rest of the input is information pertaining to the rovers that have
been deployed. Each rover has two lines of input. The first line gives the
rover's position, and the second line is a series of instructions telling
the rover how to explore the plateau.

The position is made up of two integers and a letter separated by spaces,
corresponding to the x and y co-ordinates and the rover's orientation.

Each rover will be finished sequentially, which means that the second rover
won't start to move until the first one has finished moving.


OUTPUT
The output for each rover should be its final co-ordinates and heading.

INPUT AND OUTPUT

Test Input:
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM

Expected Output:
1 3 N
5 1 E

=end

class Rover
  
  attr_reader :pos_x
  attr_reader :pos_y
  attr_reader :direction
  
  
  def initialize(pos_x, pos_y, direction, max_x, max_y)
    @pos_x = pos_x
    @pos_y = pos_y
    @direction = direction
    @max_x = max_x
    @max_y = max_y
  end
  
  
  def move_rover
    case @direction
    when 'N'
      @pos_y = (@pos_y == @max_y) ? @pos_y : (@pos_y + 1)
    when 'S'
      @pos_y = (@pos_y == 0) ? 0 : (@pos_y - 1)
    when 'E'
      @pos_x = (@pos_x == @max_x) ? @pos_x : (@pos_x + 1)
    when 'W'
      @pos_x = (@pos_x == 0) ? 0 : (@pos_x - 1)
    end
  end
  
  def move(cmd_rover)
    if cmd_rover == 'L'
      case @direction
      when 'N'
        @direction = 'W'
      when 'S'
        @direction = 'E'
      when 'E'
        @direction = 'N'
      when 'W'
        @direction = 'S'
      end
    else
      if cmd_rover == 'R'
        case @direction
        when 'N'
          @direction = 'E'
        when 'S'
          @direction = 'W'
        when 'E'
          @direction = 'S'
        when 'W'
          @direction = 'N'
        end
      else
        if cmd_rover == 'M'
          move_rover
        else
          puts "Invalid command sent to the rover :("
        end
      end
    end
  end
  
  
  def getLocation
    "#{pos_x} #{pos_y} #{direction}"
  end
end


class RoverController
  
  def initialize(grid_size)
    @max_x, @max_y = grid_size.split.map { |x| x.to_i }
  end
  
  
  def setLocation(initial_coordinates)
    initial_coordinates = initial_coordinates.chomp
    pos_x, pos_y, direction = initial_coordinates.split
    @rover = Rover.new pos_x.to_i, pos_y.to_i, direction, @max_x, @max_y
  end
  
  
  def sendCommand(cmd_rover)
    cmd_rover = cmd_rover.chomp.split(//)
    cmd_rover.each { |cmd| @rover.move cmd }
    @rover.getLocation
  end

end

grid_size = gets
max_x, max_y = grid_size.split.map { |x| x.to_i }
while true
  initial_coordinates = gets
  if initial_coordinates == nil
    break
  end
  initial_coordinates = initial_coordinates.chomp
  pos_x, pos_y, direction = initial_coordinates.split
  rover = Rover.new pos_x.to_i, pos_y.to_i, direction, max_x, max_y
  cmd_rover = gets.chomp.split(//)
  cmd_rover.each { |cmd| rover.move cmd }
  puts rover.getLocation
end


