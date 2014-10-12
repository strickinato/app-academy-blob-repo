class Maze
  attr_accessor :the_maze, :start_spot, :end_spot, :current_spot
  

  def initialize(file)
    @the_maze = generate(file)
    @start_spot = find_start
    @end_spot = find_end
    @current_spot = find_start
  end
  
  def generate(file)
    File.open(file).each_line{ |s|
      the_maze << s.rstrip.split('')
    }
  end
  
  def find_start
    start_coords = []
    the_maze.each_with_index do |row, row_index|
      row.each_with_index do |spot, col_index|
        start_coords = [row_index, col_index] if spot == 'S'
      end
    end
    
    start_coords
  end
  
  def find_end
    end_coords = []
    the_maze.each_with_index do |row, row_index|
      row.each_with_index do |spot, col_index|
        end_coords = [row_index, col_index] if spot == 'E'
      end
    end
    
    end_coords
  end
  
  def move_up
  p  @current_spot
  end
  
  def move_down
    
  end
  
  def move_left
    
  end
  
  def move_right
    
  end
  
end

our_maze = Maze.new('maze.txt')

our_maze.generate

p our_maze.the_maze
p our_maze.find_start
p our_maze.start_spot
