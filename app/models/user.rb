class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy

  before_update :check_admin_count_for_update
  before_destroy :check_admin_count_for_destroy

  private
  def check_admin_count_for_update
    users = User.all.select(:admin)
    throw(:abort) if (users.where(admin: true).count == 1) && (self.admin == false) && (self.will_save_change_to_admin?)
  end
  def check_admin_count_for_destroy
    users = User.all.select(:admin)
    throw(:abort) if (users.where(admin: true).count == 1) && (self.admin == true)
  end
end
