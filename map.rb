require 'set'
require 'pry'
require './city'
require './coordinate'

class Map
  attr_reader :cities, :adjacency

  # Constructor
  def initialize cities, adjacency
    @cities = cities
    @adjacency = adjacency
  end

  # Generates a new random instance of a map
  def self.generate
    cities = generate_cities
    Map.new(cities, generate_adjacencies(cities))
  end

  # Returns all cities adjacent to city
  def adjacent city
    @cities.select { |c| @adjacency[city.to_i][c.to_i] != 0 }
  end

  # Prints the adjacency matrix corresponding to the current instance
  def to_s
    @adjacency.map { |r| r = r.map{ |e| e.round.to_s }.join(" ") }.join("\n")
  end

  private

  # Generates 26 cities at guaranteed unique locations
  def self.generate_cities
    coords = generate_coords
    ("A".."Z").zip((0..25)).map do |pair|
      City.new(pair[0], pair[1], coords.pop)
    end
  end

  # Generates an array of unique coordinate pairs
  def self.generate_coords
    coords = ::Set.new
    random = ::Random.new
    until coords.size == 26 do
      coords << [random.rand(100), random.rand(100)]
    end
    coords.map { |c| ::Coordinate.new(c[0], c[1]) }
  end

  # Generates adjacencies for cities based on the R2 method
  # described in the project description
  def self.generate_adjacencies cities
    matrix = Array.new(26) { Array.new(26, 0) }
    cities.each do |city|
      closest = city.closest_five(cities - [city]).sample(3)
      closest.each do |c|
        matrix[city.to_i][c.to_i] = city.distance_to(c)
        matrix[c.to_i][city.to_i] = city.distance_to(c)
      end
    end
    matrix
  end
end
