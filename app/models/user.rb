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

  # Fetch CodewarsUserInfo with codewars_username field (or set a default value)
  def fetch_api_codewars_user_info
    private_fetch_user
  end

  # Helpers for Json API
  def username
    json_response["username"] if json_response
  end

  def rank
    json_response["ranks"]["overall"]["name"] if json_response
  end

  def color
    json_response["ranks"]["overall"]["color"] if json_response
  end

  private

  def private_fetch_user
    username = codewars_username || "marcoranieri"
    url = "https://www.codewars.com/api/v1/users/#{username}"
    user_json = JSON.parse(open(url).read)
    # puts JSON.pretty_generate(user_json)
    self.json_response = user_json
    self.nickname ||= username
    self.save!
  end
end
