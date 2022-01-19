class TaskTag < ApplicationRecord
  belongs_to :task
  belongs_to :tag

  # scope :tag_id, -> (tag_id) { where(tag_id: tag_id) if tag_id.present? }

end
