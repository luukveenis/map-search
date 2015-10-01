class Search
  def initialize map, initial, final
    @initial = initial
    @final = final
    @map = map
    @fringe = []
    @closed = []
  end

  # Super method to be overridden by subclasses for different algorithms
  def run
    raise "Algorithm needs to be implemented"
  end

  # Checks if the search is complete (has reached goal state)
  def done? city
    city == @final
  end

  # Generates fringe nodes for all cities adjacent to the current state.
  # Fringe nodes contains the current city and the path taken to get there.
  def expand state
    @map.adjacent(state[0]).map do |c|
      [c, state[1] + [c]]
    end
  end
end
