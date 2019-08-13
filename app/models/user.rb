require 'json'
require 'open-uri'

class User < ApplicationRecord

  after_create :fetch_api_codewars_user_info

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations
  has_many :rounds, through: :participations
  has_many :games

  # Fetch CodewarsUserInfo with codewars_username field (or set a default value)
  def fetch_api_codewars_user_info
    private_fetch_user_info
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

  def completed
    json_completed_katas["data"] if json_completed_katas
  end

  private

  def private_fetch_user_info
  # after_tansaction callback gem - https://github.com/grosser/ar_after_transaction
    ActiveRecord::Base.after_transaction do
      if codewars_username
        begin
          url = "https://www.codewars.com/api/v1/users/#{codewars_username}"
          # puts JSON.pretty_generate(JSON.parse(open(url).read))
          self.json_response = JSON.parse(open(url).read)
          self.json_completed_katas = CodewarsApiFetch.completed_kata(codewars_username, codewars_api_key)
          self.nickname ||= codewars_username
          self.save!
        rescue
          return
        end
      end
    end
  end
end
