FactoryBot.define do
  factory :game_budget_category do
    name { "MyString" }
    current_value { "" }
    expected_value { "" }
    positive_combo { 1 }
    negative_combo { 1 }
  end
end
