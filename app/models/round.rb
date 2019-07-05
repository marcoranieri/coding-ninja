class Round < ApplicationRecord
  belongs_to :game
  has_many :participations
  has_many :users, through: :participations
end
