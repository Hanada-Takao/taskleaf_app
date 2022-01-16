class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :tasks, dependent: :destroy

  before_destroy :must_not_destroy_last_one_admin
  before_update :must_not_update_last_one_admin

  private

  def must_not_destroy_last_one_admin
    if User.where(admin: true).count == 1 && self.admin == true
      throw(:abort)
    end
  end

  def must_not_update_last_one_admin
    if User.where(admin: true).count == 1 && self.admin == false && self.changes[:admin].nil? == false
      throw(:abort)
      end
  end
end
