class PlayProceed
  def initialize(play)
    @play = play
  end

  def proceed
    proceed_play_to_next_month
    calculate_combo
    calculate_satisfaction
  end

  private

  def proceed_play_to_next_month
    if @play.current_month < 60
      next_month = @play.current_month + 1
      @play.update(current_month: next_month)
    else
      next_month = @play.current_month + 1
      @play.update(current_month: next_month, finished_at: Time.now)
    end
  end

  def calculate_combo
    @play.game_budget_categories.each do |game_budget|
      if game_budget.expected_value > game_budget.current_value
        new_negative_combo = game_budget.negative_combo + 1
        new_positive_combo = 0
      else
        new_negative_combo = 0
        new_positive_combo = game_budget.positive_combo + 1
      end
      game_budget.update(negative_combo: new_negative_combo, positive_combo: new_positive_combo)
    end
  end

  def calculate_satisfaction
    new_satisfaction = @play.social_satisfaction.to_f
    full_budget = @play.game_budget_categories.sum(&:expected_value)
    impact_multiplier = 10.0

    @play.game_budget_categories.each do |game_budget|
      expected = game_budget.expected_value.to_f
      current = game_budget.current_value.to_f
      next if expected.zero?

      percent_diff = (current - expected) / expected
      budget_share = expected / full_budget
      combo = percent_diff < 0 ? game_budget.negative_combo : game_budget.positive_combo

      change = percent_diff * budget_share * combo * impact_multiplier
      new_satisfaction += change
    end

    new_satisfaction = new_satisfaction.round(5).clamp(0, 99.99)
    @play.update!(social_satisfaction: new_satisfaction)
  end
end
