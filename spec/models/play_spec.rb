require 'rails_helper'

RSpec.describe Play, type: :model do
  include ActionView::Helpers::NumberHelper

  let(:events_data) do
    file_path = Rails.root.join('spec', 'support', 'data', 'events.json')
    JSON.parse(File.read(file_path))
  end

  before do
    BudgetCategory.seed
    events_data.each do |event|
      event["id"] = nil
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
    end
  end

  it "should be a play" do
    won = 0
    defeat = 0
    social_satisfaction_win = []
    social_satisfaction_defeat = []
    100.times do |i|
      user = User.create!(
        password: "12345678",
        password_confirmation: "12345678",
        email: "test#{i}@example.com",
        first_name: "Tester",
        last_name: "Tester",
        name: "Tester#{i}",
        time_of_acceptance_of_information_on_the_processing_of_personal: DateTime.now,
        time_of_acceptance_of_the_regulations: DateTime.now
      )

      play = Play.create!
      play.users << user

      finish_positive_play(play)
      positive_event_ids = play.play_events.select(&:is_positive_to_player?).map(&:event_id)

      puts "Play #{i} done #{play.result} with #{play.social_satisfaction} on #{play.current_month} reserve #{number_with_delimiter(play.budget_reserve * 1_000, delimiter: " ") + " zł"} + #{positive_event_ids.count} positive"
      won += 1 if play.result == "win"
      defeat += 1 if play.result == "defeat"
      social_satisfaction_win << play.social_satisfaction if play.result == "win"
      social_satisfaction_defeat << "#{play.social_satisfaction} on #{play.current_month}" if play.result == "defeat"
      if i%10==9
        puts "#{social_satisfaction_win.count} #{social_satisfaction_win.inspect}"
        puts "#{social_satisfaction_defeat.count} #{social_satisfaction_defeat.inspect}"
      end

      expect(positive_event_ids).to eq(positive_event_ids.uniq)
      expect(play.reload.social_satisfaction).to_not eq(99.99)
    end
  end
end
