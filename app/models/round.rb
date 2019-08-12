require 'json'
require 'open-uri'

class Round < ApplicationRecord
  after_create :private_fetch_kata

  belongs_to :game #, optional: true

  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  # Fetch KataInfo with kata_id or slug
  def fetch_api_codewars_kata_info
    private_fetch_kata
  end

  def kata_name
    json_response["name"] if json_response
  end

  def kata_category
    json_response["category"] if json_response
  end

  def kata_url
    json_response["url"] if json_response
  end

  def kata_rank
    json_response["rank"]["name"] if json_response
  end

  def kata_color
    json_response["rank"]["color"] if json_response
  end

  def kata_description
    json_response["description"] if json_response
  end

  private

  def private_fetch_kata
    kata_ref = kata_id || "valid-braces" # :id_or_slug
    self.json_response = CodewarsApiFetch.kata_info(kata_ref)
    self.save!
  end
end
