class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :varidate_name_not_including_comma

  private

  def varidate_name_not_including_comma
    errors.add(:name, 'にコンマを含めることはできません') if name&.include?(',')
  end
end
