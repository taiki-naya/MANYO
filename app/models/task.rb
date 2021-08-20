class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  def self.search(search, status)
    status_num = status["status"]
    if search
      Task.where('title LIKE ?', "%#{search}%").where("status = #{status_num}")
    else
      Task.where("status = #{status_num}")
    end
  end

end
