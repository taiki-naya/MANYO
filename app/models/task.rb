class Task < ApplicationRecord
  validates :name, length: { maximum: 100 }
end
