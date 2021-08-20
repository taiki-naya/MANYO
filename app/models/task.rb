class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true

  scope :default_order, -> { order(created_at: :desc) }

  def self.search(search, status)
    status_num = status["status"]
    scope :by_title, -> { where('title LIKE ?', "%#{search}%")}
    scope :by_status, -> { where("status = #{status_num}")}
    if search
      if status_num == '10'
        Task.by_title
      else
        Task.by_title.by_status
      end
    else
      if status_num == '10'
        Task.all
      else
        Task.by_status
      end
    end
  end

end
