class Coordinate
  attr_reader :x, :y

  def initialize x, y
    @x = x
    @y = y
  end

  def distance_to other
    Math.sqrt((other.x - @x) ** 2 + (other.y - @y) ** 2)
  end
end
