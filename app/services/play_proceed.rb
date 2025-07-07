class PlayProceed
  def initialize(play)
    @play = play
  end

  def proceed
    current_month = @play.current_month
    next_month = current_month + 1
    resolve_previous_events(current_month) if current_month > 0
    3.times do
      draw_event_for_next_month(next_month)
    end
    proceed_play_to_next_month
    calculate_combo
    calculate_satisfaction
    eliminate_overloaded
  end

  private

  def draw_event_for_next_month(month)
    event = Event.take_random
    return unless event

    @play.play_events.create!(
      event: event,
      month: month,
      outcome: nil,
      resolved_at: nil
    )
  end

  def resolve_previous_events(current_month)
    previous_events = @play.play_events.where(month: current_month)
    previous_events.each do |event|
      resolve_previous_event(event)
    end
  end

  def resolve_previous_event(previous_event)
    event = previous_event.event

    outcome = check_budget_status(event)

    previous_event.update!(outcome: outcome, resolved_at: Time.current)
  end

  def check_budget_status(event)
    if event.budget_name
      gbc = @play.game_budget_categories.find_by(name: event.budget_name)
      return "neutral" unless gbc

      gbc.current_value >= gbc.expected_value ? "positive" : "negative"
    else
      "neutral"
    end
  end

  def proceed_play_to_next_month
    if @play.current_month < 47
      next_month = @play.current_month + 1
      @play.update(current_month: next_month)
    else
      next_month = @play.current_month + 1
      @play.update(current_month: next_month, finished_at: Time.now)
    end
  end

  def calculate_combo
    @play.game_budget_categories.each do |game_budget|
      if game_budget.expected_value < game_budget.current_value
        new_negative_combo = 0
        new_positive_combo = game_budget.positive_combo + 1
      elsif game_budget.expected_value > game_budget.current_value
        new_negative_combo = game_budget.negative_combo + 1
        new_positive_combo = 0
      else
        new_negative_combo = 0
        new_positive_combo = 0
      end
      game_budget.update(negative_combo: new_negative_combo, positive_combo: new_positive_combo)
    end
  end

  def calculate_impacts
    positive_budgets = 0
    negative_budgets = 0
    all_budgets = @play.game_budget_categories.count
    @play.game_budget_categories.each do |game_budget|
      if game_budget.expected_value < game_budget.current_value
        positive_budgets += 1
      elsif game_budget.expected_value > game_budget.current_value
        negative_budgets += 1
      end
    end
    [ positive_budgets.to_f / all_budgets.to_f, negative_budgets.to_f / all_budgets.to_f ]
  end

  def calculate_satisfaction
    new_satisfaction = @play.social_satisfaction.to_f
    full_budget = @play.game_budget_categories.sum(&:expected_value)
    impact_multiplier = 5
    positive_impact, negative_impact = calculate_impacts
    positive_impact = impact_multiplier * positive_impact
    negative_impact = impact_multiplier * negative_impact

    @play.game_budget_categories.each do |game_budget|
      last_seen_multiplier = was_last_exists(game_budget) ? 250 : 5
      expected = game_budget.expected_value.to_f
      current = game_budget.current_value.to_f
      next if expected.zero?

      percent_diff = (current.to_f - expected.to_f) / expected.to_f
      budget_share = expected.to_f / full_budget.to_f
      combo = percent_diff < 0 ? game_budget.negative_combo : game_budget.positive_combo
      impact = percent_diff < 0 ? negative_impact.clamp(0, 20) : positive_impact.clamp(0, 10)
      combo = 1 if combo == 0
      impact = 1 if impact == 0

      change = percent_diff.to_f * budget_share.to_f * combo.to_f * last_seen_multiplier.to_f * impact.to_f
      change = change.clamp(-1.0, 1.0)

      new_satisfaction += change
    end

    new_satisfaction = new_satisfaction.round(5).clamp(0, 99.99)
    if new_satisfaction < 10
      @play.update!(finished_at: Time.now)
    end
    @play.update!(social_satisfaction: new_satisfaction)
  end

  def was_last_exists(game_budget)
    previous_month = @play.current_month - 1
    @play.play_events.includes(:event).where(month: previous_month).where("event.budget_name": game_budget.name).any?
  end

  def eliminate_overloaded
    @play.game_budget_categories.each do |game_budget|
      expected = game_budget.expected_value.to_f
      current = game_budget.current_value.to_f
      if current > expected + 5000
        new_expected = expected + ((current - expected) / 2)
        game_budget.update(expected_value: new_expected)
      end
    end
  end
end
