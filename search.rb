require_relative 'euclidian'

class Search
  def initialize map, initial, final
    @initial = initial
    @final = final
    @map = map
  end

  # Runs all implemented search algorithms and returns an array of results
  def run_all
    results = []
    results << { name: "DFS", result: dfs(Float::INFINITY) }
    results << { name: "BFS", result: bfs }
    results << { name: "Iterative DFS", result: iterative_dfs }
    results << { name: "Greedy", result: greedy(Euclidian.new(@final)) }
  end

  # Perform (depth-limited) DFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected graph)
  # To perform regular DFS simply pass in Float::INFINITY for max_depth
  def dfs max_depth
    closed = []
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty?
      current = fringe.pop
      city = current[:city]
      return current if done? city
      unless closed.include?(city) || current[:depth] >= max_depth
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
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty?
      current = fringe.pop
      city = current[:city]
      return current if done? city
      unless closed.include? city
        closed.push city
        expand(current).each do |c|
          fringe.unshift(c)
        end
      end
    end
  end

  def iterative_dfs
    (1..@map.cities.count).each do |i|
      result = dfs(i)
      return result if result
    end
    return nil
  end

  def greedy strategy
    closed = []
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty?
      current = fringe.delete(strategy.next(fringe))
      city = current[:city]
      return current if done? city
      unless closed.include? city
        closed.push city
        fringe = fringe + expand(current)
      end
    end
  end

  # Checks if the search is complete (has reached goal state)
  def done? city
    city == @final
  end

  def initialize_fringe
      [{
        city: @initial,
        path: [@initial],
        depth: 1
      }]
  end

  # Generates fringe nodes for all cities adjacent to the current state.
  # Fringe nodes contains the current city and the path taken to get there.
  def expand state
    @map.adjacent(state[:city]).map do |c|
      {
        city: c,
        path: state[:path] + [c],
        depth: state[:depth] + 1
      }
    end
  end
end
