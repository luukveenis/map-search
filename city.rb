class City
  attr_reader :name, :coord

  def initialize name, val, coord
    @name = name
    @val = val
    @coord = coord
    @visited = false
  end

  def distance_to other
    @coord.distance_to(other.coord)
  end

  def closest_five cities
    cities.sort_by { |city| city.distance_to(self) }.first(5)
  end

  def to_i
    @val
  end
end
