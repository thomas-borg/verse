class Sport < ApplicationRecord

  validates :name, presence: true
  validates :category, presence: true

  has_one_attached :photo
end
