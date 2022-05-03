class DailyElapsedTime < ApplicationRecord
  validates :uuid, uniqueness: { scope: :target_date }
  validates :target_date, presence: true
  validates :todo, presence: true
  validates :elapsed_seconds, presence: true
end
