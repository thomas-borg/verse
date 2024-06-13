class Activity < ApplicationRecord
  after_save :set_short_address, if: -> { saved_change_to_location? }

  def short_address
    if super.blank?
      set_short_address
    else
      super
    end
  end

  def set_short_address
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Based on this address: #{location}, tell me the suburb first and then the city (not postcode), separated by a comma, without any description or explaination. e.g. 'Joordan, Amsterdam', 'Amsterdam-Zuid, Amsterdam', 'Nieuw-West, Amsterdam' "}]
    })
    new_content = chatgpt_response["choices"][0]["message"]["content"]
    update(short_address: new_content)
    return new_content
  end

  belongs_to :user
  belongs_to :sport
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :messages

  validates :location, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :date_time, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

end
