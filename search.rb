class Search
  def initialize map, initial, final
    @initial = initial
    @final = final
    @map = map
  end

  # Runs all implemented search algorithms and returns an array of results
  def run_all
    results = []
    results << { name: "DFS", result: dfs }
    results << { name: "BFS", result: bfs }
  end

  # Perform DFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected graph)
  def dfs
    closed = []
    fringe = [[@initial, [@initial]]]

    loop do
      return nil if fringe.empty?
      current = fringe.pop
      city = current[0]
      return current[1] if done? city
      unless closed.include? city
        closed.push city
        fringe = fringe + expand(current)
      end
    end
  end

  # Perform BFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected path)
  def bfs
    closed = []
    fringe = [[@initial, [@initial]]]

    loop do
      return nil if fringe.empty?
      current = fringe.pop
      city = current[0]
      return current[1] if done? city
      unless closed.include? city
        closed.push city
        expand(current).each do |c|
          fringe.unshift(c)
        end
      end
    end
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
