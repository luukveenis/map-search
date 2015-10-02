require_relative 'strategy'

class Euclidian < Strategy
  def next states
    states.min_by { |s| s[:city].distance_to(@goal) }
  end
end
