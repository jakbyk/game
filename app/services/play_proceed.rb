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

  def calculate_satisfaction
    new_satisfaction = @play.social_satisfaction.to_f
    full_budget = @play.game_budget_categories.sum(&:expected_value)
    impact_multiplier = 100

    @play.game_budget_categories.each do |game_budget|
      last_seen_multiplier = was_last_exists(game_budget) ? 100 : 1
      expected = game_budget.expected_value.to_f
      current = game_budget.current_value.to_f
      next if expected.zero?

      percent_diff = (current - expected) / expected
      budget_share = expected / full_budget
      combo = percent_diff < 0 ? game_budget.negative_combo : game_budget.positive_combo

      change = percent_diff * budget_share * combo * impact_multiplier * last_seen_multiplier
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
end
