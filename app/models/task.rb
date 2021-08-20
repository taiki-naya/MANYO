class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  def self.search(search, status)
    status_num = status["status"]
    if search
      if status_num == '10'
        Task.where('title LIKE ?', "%#{search}%")
      else
        Task.where('title LIKE ?', "%#{search}%").where("status = #{status_num}")
      end
    else
      if status_num == '10'
        Task.all
      else
        Task.where("status = #{status_num}")
      end
    end
  end

end
