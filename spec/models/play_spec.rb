require 'rails_helper'

RSpec.describe Play, type: :model do
  let(:events_data) do
    file_path = Rails.root.join('spec', 'support', 'data', 'events.json')
    JSON.parse(File.read(file_path))
  end

  before do
    BudgetCategory.seed
    events_data.each do |event|
      Event.new(event).save
    end
  end

  def finish_positive_play(play)
    while play.is_active?
      play = play.reload
      play_events = play.play_events.where(month: play.current_month)
      play_events.each do |pe|
        event = pe.event
        if event.is_adding_to_budget
          gbc = GameBudgetChange.new(play: play, user: play.users.first, name: event.budget_name, value: event.budget_change, is_adding: true)
          gbc.save
          GameBudgetChangeVote.new(game_budget_change: gbc, user: play.users.first, vote: true).save
        end
      end
      play.proceed
      puts "=========================================================="
      puts play.current_month
      puts play.social_satisfaction
    end
  end

  it "should be a play" do
    user = User.new(password: "12345678", password_confirmation: "12345678", email: "test@example.com", first_name: "Tester", last_name: "Tester", name: "Tester", time_of_acceptance_of_information_on_the_processing_of_personal: DateTime.now, time_of_acceptance_of_the_regulations: DateTime.now)
    user.save
    play = Play.new
    play.users << user
    play.save
    finish_positive_play(play)
    expect(play.valid?).to be true
  end
end
