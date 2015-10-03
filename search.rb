require_relative 'euclidian'
require_relative 'zero'

# Class to run the 5 different search algorithms required by this project
# These algorithms include:
# - DFS
# - BFS
# - Iterative Deepening Search
# - Greedy Search
# - A* Search
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
    results << { name: "Iterative DFS", result: iterative_dfs }
    results << { name: "Greedy Euc.", result: greedy(Euclidian.new(@final, false)) }
    results << { name: "Greedy Zero", result: greedy(Zero.new(@final, false)) }
    results << { name: "A Star Euc.", result: a_star(Euclidian.new(@final, true)) }
    results << { name: "A Star Zero", result: a_star(Zero.new(@final, true)) }
  end

  # Perform (depth-limited) DFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected graph)
  # To perform regular DFS simply pass in Float::INFINITY for max_depth
  def dfs
    closed = []
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty? # No solution
      current = fringe.pop
      city = current[:city]
      return current if done? city # Found the solution?
      unless closed.include?(city) # Expand if we have not visited the city
        closed.push city
        fringe = fringe + expand(current) # Add to end for FILO
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
      return nil if fringe.empty? # No solution
      current = fringe.pop
      city = current[:city]
      return current if done? city # Found the solution?
      unless closed.include? city  # Expand if we haven't visited the city
        closed.push city
        expand(current).each do |c|
          fringe.unshift(c) # Add to front to ensure FIFO
        end
      end
    end
  end

  # Implements iterative deepening search by continuously calling
  # depth limited search with increasing depths
  def iterative_dfs
    (1..@map.cities.count).each do |i| # Path can't be longer than # cities
      result = dls(i)
      return result if result
    end
    return nil
  end

  def dls max
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty? # No solution
      current = fringe.pop
      city = current[:city]
      return current if done? city  # Found solution?
      unless current[:depth] >= max # Stop if we've reached max depth
        fringe = fringe + expand(current)
      end
    end
  end

  # Implements greedy search, choosing nodes to expand based on strategy
  def greedy strategy
    closed = []
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty? # No solution
      current = fringe.delete(strategy.next(fringe)) # Pick next using heuristic
      city = current[:city]
      return current if done? city # Found solution?
      unless closed.include? city  # Only expand new cities
        closed.push city
        fringe = fringe + expand(current)
      end
    end
  end

  # Implements A* Search, choosing nodes to expand based on strategy
  def a_star strategy
    closed = []
    fringe = initialize_fringe

    loop do
      return nil if fringe.empty? # No solution

      current = fringe.delete(strategy.next(fringe)) # Pick next using heuristic
      city = current[:city]

      return current if done? city # Found solution?
      unless closed.include? city  # Only expand new cities
        closed.push city
        fringe = fringe + expand(current)
      end
    end
  end

  # Checks if the search is complete (has reached goal state)
  def done? city
    city == @final
  end

  # Creates the fringe array containing the initial node
  def initialize_fringe
      [{
        city: @initial,
        path: [@initial],
        depth: 1,
        cost: 0
      }]
  end

  # Generates fringe nodes for all cities adjacent to the current state.
  # Fringe nodes contains the current city and the path taken to get there.
  def expand state
    @map.adjacent(state[:city]).map do |c|
      {
        city: c,
        path: state[:path] + [c],
        depth: state[:depth] + 1,
        cost: state[:cost] + state[:city].distance_to(c)
      }
    end
  end
end
