require_relative 'search'
require 'pry'

class DFS < Search

  # Perform DFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected graph)
  def run
    @fringe.push [@initial, [@initial]]

    loop do
      return nil if @fringe.empty?
      current = @fringe.pop
      city = current[0]
      return current[1] if done? city
      unless @closed.include? city
        @closed.push city
        @fringe = @fringe + expand(current)
      end
    end
  end
end
