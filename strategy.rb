class Strategy
  def initialize goal
    @goal = goal
  end

  # Returns the next most desirable state according to
  # the strategy
  def next states, goal
    raise "Must be implemented by subclass"
  end
end
