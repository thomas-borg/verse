class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :users, through: :member

  validates :location, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :date_time, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
