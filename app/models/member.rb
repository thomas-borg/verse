class Member < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  validates :activity, uniqueness: { scope: :user, message: "User already request this activity" }
end
