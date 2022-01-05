class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :deadline, presence: true
  validate :varidate_name_not_including_comma

  scope :recent, -> { order(created_at: :desc)}

  enum status:{未着手:1, 着手:2, 完了:3}

  private

  def varidate_name_not_including_comma
    errors.add(:name, 'にコンマを含めることはできません') if name&.include?(',')
  end

  def self.lastest(number)
    order(created_at: :desc).limit(number)
  end
end
