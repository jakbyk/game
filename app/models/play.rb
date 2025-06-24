class Play < ApplicationRecord
  START_YEAR = 2025
  MONTH_NAMES = %w[Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień].freeze
  REGIONS = {
    "PL32": "Zachodniopomorskie",
    "PL22": "Pomorskie",
    "PL28": "Warminsko-mazurskie",
    "PL20": "Podlasie",
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

  belongs_to :archived_by, class_name: "User", optional: true

  after_create :create_chat
  after_create :create_game_budget_categories
  after_create :set_budget_reserve

  scope :archived, -> { unscoped.where.not(archived_at: nil) }
  scope :active, -> { where(archived_at: nil).where(finished_at: nil) }
  scope :finished, -> { unscoped.where.not(finished_at: nil) }
  default_scope -> { active }

  validate :only_one_of_archived_or_finished

  def archive(user)
    return unless user.is_admin? || play_users.find_by(user: user).is_leader
    update(archived_at: Time.now, archived_by: user)
  end

  def name_of_current_month
    years = current_month / 12
    month = current_month % 12
    "#{MONTH_NAMES[month]} #{START_YEAR+years}"
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
