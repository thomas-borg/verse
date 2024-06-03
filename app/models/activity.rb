class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :sport

  validates :location, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :date_time, presence: true
end
