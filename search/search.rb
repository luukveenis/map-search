class Search
  def initialize map
    @initial = map.cities.sample # pick a random start city
    @final = map.cities.sample   # pick a random end city
    @map = map
    @fringe = []
    @closed = []
  end

  # Checks if the search is complete (has reached goal state)
  def done? city
    city == @final
  end

  # Generates fringe nodes for all cities adjacent to the current state.
  # Fringe nodes contains the current city and the path taken to get there.
  def expand state
    @map.adjacent(state[0]).select { |c| !@closed.include?(c) }.map do |c|
      [c, state[1] + [c]]
    end
  end
end
