class Play < ApplicationRecord
  START_YEAR = 2025
  MONTH_NAMES = %w[Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień].freeze
  REGIONS = {
    "PL32": "Zachodniopomorskie",
    "PL22": "Pomorskie",
    "PL28": "Warmińsko-mazurskie",
    "PL20": "Podlaskie",
    "PL14": "Mazowieckie",
    "PL04": "Kujawsko-pomorskie",
    "PL30": "Wielkopolskie",
    "PL08": "Lubuskie",
    "PL02": "Dolnośląskie",
    "PL16": "Opolskie",
    "PL24": "Śląskie",
    "PL10": "Łódzkie",
    "PL26": "Świętokrzyskie",
    "PL12": "Małopolskie",
    "PL18": "Podkarpackie",
    "PL06": "Lubelskie"
  }

  has_one :chat, dependent: :destroy
  has_many :play_users, dependent: :destroy
  has_many :users, through: :play_users
  has_many :game_budget_categories, dependent: :destroy
  has_many :game_budget_changes, dependent: :destroy
  has_many :play_events, dependent: :destroy
  has_many :play_invitations, dependent: :destroy

  belongs_to :archived_by, class_name: "User", optional: true

  after_create :create_chat
  after_create :create_game_budget_categories
  after_create :set_budget_reserve

  scope :archived, -> { where.not(archived_at: nil).order(id: :desc) }
  scope :active, -> { where(archived_at: nil).where(finished_at: nil).order(id: :desc) }
  scope :finished, -> { where.not(finished_at: nil).order(id: :desc) }
  scope :won, -> { where.not(finished_at: nil).where("social_satisfaction > ?", 10).order(id: :desc) }
  scope :done, -> { where.not(archived_at: nil)
                         .or(where.not(finished_at: nil))
                         .order(id: :desc)
  }

  validate :only_one_of_archived_or_finished
  validates :current_month, inclusion: { in: (0..48) }

  def archive(user)
    return unless user.is_admin? || play_users.find_by(user: user).is_leader
    update(archived_at: Time.now, archived_by: user)
  end

  def name_of_current_month
    if current_month < 48
      years = current_month / 12
      month = current_month % 12
      "#{MONTH_NAMES[month]} #{START_YEAR + years}"
    else
      "Koniec gry"
    end
  end

  def proceed
    PlayProceed.new(self).proceed
  end

  def is_active?
    finished_at.nil? && archived_at.nil?
  end

  def is_finished?
    !finished_at.nil? && archived_at.nil?
  end

  def is_archived?
    finished_at.nil? && !archived_at.nil?
  end

  def result
    return "active" if is_active?
    return "subjected" if is_archived? && current_month < 48
    return "defeat" if is_finished? && social_satisfaction < 10.0
    "win"
  end

  def social_satisfaction_description
    social_satisfaction_levels = Setting.first.social_satisfaction_levels
    return "" if social_satisfaction_levels.blank?

    applicable = social_satisfaction_levels
                   .select { |level| social_satisfaction >= level["threshold"].to_i }
                   .max_by { |level| level["threshold"].to_i }

    applicable&.dig("text").to_s.html_safe
  end

  private

  def create_chat
    chat = Chat.new(play: self)
    chat.save!
  end

  def only_one_of_archived_or_finished
    if archived_at.present? && finished_at.present?
      errors.add(:base, "Nie można oznaczyć gry jako zakończonej i zarchiwizowanej jednocześnie.")
    end
  end

  def create_game_budget_categories
    BudgetCategory.get(name: "Rolnictwo i łowiectwo")
    BudgetCategory.all.each do |category|
      game_budget_categories.new(name: category.name,
                                 current_value: category.start_budget,
                                 expected_value: category.start_budget).save!
    end
  end

  def set_budget_reserve
    self.update(budget_reserve: 10_000_000)
  end
end
