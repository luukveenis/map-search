class Strategy
  def initialize goal, use_cost
    @goal = goal
    @use_cost = use_cost
  end

  # Returns the next most desirable state according to
  # the strategy
  def next states
    raise "Must be implemented by subclass"
  end
end
