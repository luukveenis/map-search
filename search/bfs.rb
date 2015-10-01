require_relative 'search'

class BFS < Search

  # Perform BFS:
  # Returns the computed path if one is found
  # Returns nil if no path is found (can happen for disconnected path)
  def run
    @fringe.unshift [@initial, [@initial]]

    loop do
      return nil if @fringe.empty?
      current = @fringe.pop
      city = current[0]
      return current[1] if done? city
      unless @closed.include? city
        @closed.push city
        expand(current).each do |c|
          @fringe.unshift(c)
        end
      end
    end

  end
end
