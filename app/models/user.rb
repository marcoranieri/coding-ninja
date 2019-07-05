require 'json'
require 'open-uri'

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations
  has_many :rounds, through: :participations
  has_many :games

### Fetch CodewarsUserInfo with codewars_username field (or set a default value)
  def fetch_codewars_api_info
    username = codewars_username || "marcoranieri"
    url = "https://www.codewars.com/api/v1/users/#{username}"
    user = JSON.parse(open(url).read)
    # puts JSON.pretty_generate(user)
    self.json_response = user
  end
end
