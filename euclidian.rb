require_relative 'strategy'

class Euclidian < Strategy
  def next states
    if @use_cost
      states.min_by { |s| s[:cost] + s[:city].distance_to(@goal) }
    else
      states.min_by { |s| s[:city].distance_to(@goal) }
    end
  end
end
