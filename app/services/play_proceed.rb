class PlayProceed
  def initialize(play)
    @play = play
    @last_10_events_ids = @play.play_events.map(&:event_id).uniq[0..10]
    @previous_positive_events_ids = @play.play_events.select(&:is_positive_to_player?).map(&:event_id)
  end

  def proceed
    current_month = @play.current_month
    check_budget_reserve_influence
    resolve_previous_events(current_month)
    make_new_events(current_month + 1)
    proceed_play_to_next_month
    calculate_combo
    calculate_satisfaction
    eliminate_overloaded
  end

  def make_new_events(month)
    rand(3..6).times do |i|
      draw_event_for_next_month(month, take_negative: i < 4)
    end
  end

  private

  def draw_event_for_next_month(month, take_negative: false)
    event = take_event(take_negative: take_negative)
    return unless event

    positive, negative = calculate_potentials(event)
    @play.play_events.create!(
      event: event,
      month: month,
      outcome: nil,
      resolved_at: nil,
      potential_increase_of_satisfaction: positive,
      potential_decrease_of_satisfaction: negative
    )
  end

  def take_event(take_negative: false)
    event = nil
    if @play.social_satisfaction > 60 && take_negative
      event = Event.take_negative
    end
    while event == nil
      new_event = Event.take_random
      if !@last_10_events_ids.include?(new_event&.id) && !@previous_positive_events_ids.include?(new_event&.id)
        event = new_event
        @last_10_events_ids << new_event&.id
      end
    end
    event
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

    if event.region
      if outcome == "positive"
        @play.increment_region_satisfaction(Play::REGIONS.key(event.region).to_s)
        @play.increment_region_satisfaction(Play::REGIONS.key(event.region).to_s) if event.budget_change > 1000
        @play.increment_region_satisfaction(Play::REGIONS.key(event.region).to_s) if event.budget_change > 10000
      elsif outcome == "negative"
        @play.decrement_region_satisfaction(Play::REGIONS.key(event.region).to_s)
        @play.decrement_region_satisfaction(Play::REGIONS.key(event.region).to_s) if event.budget_change > 1000
        @play.decrement_region_satisfaction(Play::REGIONS.key(event.region).to_s) if event.budget_change > 10000
      end
    end
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
      important_to_region_multiplier = calculate_important_to_region(game_budget, current >= expected)
      next if expected.zero?

      percent_diff = (current.to_f - expected.to_f) / expected.to_f
      budget_share = expected.to_f / full_budget.to_f
      combo = percent_diff < 0 ? game_budget.negative_combo : game_budget.positive_combo
      impact = percent_diff < 0 ? negative_impact.clamp(0, 20) : positive_impact.clamp(0, 10)
      combo = 1 if combo == 0
      impact = 1 if impact == 0

      change = percent_diff.to_f * budget_share.to_f * combo.to_f * last_seen_multiplier.to_f * impact.to_f * important_to_region_multiplier.to_f
      change = change.clamp(-1.0, 1.0)

      new_satisfaction += change
    end

    new_satisfaction = new_satisfaction.round(5).clamp(0, 99.99)
    if new_satisfaction < 10
      @play.update!(finished_at: Time.now)
    end
    @play.update!(social_satisfaction: new_satisfaction)
  end

  def check_budget_reserve_influence
    if @play.budget_reserve < 0
      change = calculate_satisfaction_reduction(@play.budget_reserve.abs)
      new_satisfaction = @play.social_satisfaction.to_f
      new_satisfaction -= change
      new_satisfaction = new_satisfaction.round(5).clamp(0, 99.99)
      if new_satisfaction < 10
        @play.update!(finished_at: Time.now)
      end
      @play.update!(social_satisfaction: new_satisfaction)
    end
  end

  def calculate_satisfaction_reduction(n)
    return 0.01 if n <= 1
    return 100 if n >= 10_000_000

    min_val = 0.01
    max_val = 100.0
    alpha = 0.6

    ratio = (n - 1).to_f / (10_000_000.0 - 1)
    (min_val + (max_val - min_val) * (ratio ** alpha))
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

  def calculate_important_to_region(game_budget, positive)
    previous_month = @play.current_month - 1
    previous_events_for_this_game_budget = @play.play_events.includes(:event).where(month: previous_month).where("event.budget_name": game_budget.name)
    return 1 unless previous_events_for_this_game_budget.any?

    important_region_multiplier = 1
    previous_events_for_this_game_budget.each do |play_event|
      if play_event.event.region
        id_of_region = Play::REGIONS.key(play_event.event.region).to_s
        satisfy = @play.get_region_satisfaction(id_of_region)
        if (1..10).include?(satisfy) && play_event.outcome == "negative" && !positive
          important_region_multiplier += (satisfy - 10).abs
        end
      end
    end
    important_region_multiplier
  end

  def calculate_potentials(event)
    return [ nil, nil ] unless event.is_adding_to_budget
    full_budget = @play.game_budget_categories.sum(&:expected_value)
    impact_multiplier = 5
    positive_impact, negative_impact = calculate_impacts
    positive_impact = impact_multiplier * positive_impact
    negative_impact = impact_multiplier * negative_impact
    game_budget = @play.game_budget_categories.find_by(name: event.budget_name)
    last_seen_multiplier = 250000
    expected = game_budget.expected_value.to_f + event.budget_change
    negative_current = game_budget.current_value.to_f
    positive_current = game_budget.current_value.to_f + event.budget_change
    positive_important_to_region_multiplier = calculate_important_to_region(game_budget, true)
    negative_important_to_region_multiplier = calculate_important_to_region(game_budget, false)
    return [ nil, nil ] if expected.zero?

    positive_percent_diff = (positive_current.to_f - expected.to_f) / expected.to_f
    negative_percent_diff = (negative_current.to_f - expected.to_f) / expected.to_f
    budget_share = expected.to_f / full_budget.to_f
    negative_combo = game_budget.negative_combo
    positive_combo = game_budget.positive_combo
    negative_impact = negative_impact.clamp(0, 20)
    positive_impact = positive_impact.clamp(0, 20)
    negative_combo = 1 if negative_combo == 0
    positive_combo = 1 if positive_combo == 0
    negative_impact = 1 if negative_impact == 0
    positive_impact = 1 if positive_impact == 0
    positive = positive_percent_diff.to_f * budget_share.to_f * positive_combo * last_seen_multiplier.to_f * positive_impact.to_f * positive_important_to_region_multiplier.to_f
    negative = negative_percent_diff.to_f * budget_share.to_f * negative_combo * last_seen_multiplier.to_f * negative_impact.to_f * negative_important_to_region_multiplier.to_f
    positive = positive.abs
    negative = negative.abs

    [ positive, negative ]
  end
end
