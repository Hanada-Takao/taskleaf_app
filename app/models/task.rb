class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true
  validate :varidate_name_not_including_comma

  belongs_to :user
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  scope :recent, -> { order(created_at: :desc)}
  scope :priority_sorted, -> { order(priority: :desc) }

  enum status:{未着手:0, 着手:1, 完了:2}
  enum priority:{高:0, 中:1, 低:2}
  scope :name_like, -> (name) { where('name LIKE ?', "%#{ name }%") if name.present? }
  scope :status, -> (status) { where(status: status) if status.present? }
  scope :tag_id, -> (tag_id) {
    joins(:task_tags).where(task_tags: {tag_id: tag_id}) if tag_id.present?
  }

  private

  def varidate_name_not_including_comma
    errors.add(:name, 'にコンマを含めることはできません') if name&.include?(',')
  end

  def self.lastest(number)
    order(created_at: :desc).limit(number)
  end

  scope :searchh, -> (search_params) do
    return if search_params.blank?

    name_like(search_params[:name]).status(search_params[:status]).tag_id(search_params[:tag_id])
  end


end