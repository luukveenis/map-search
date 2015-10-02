class Zero < Strategy
  def next states
    if @use_cost
      states.min_by { |s| s[:cost] + 0 }
    else
      states.min_by { |s| 0 }
    end
  end
end
