class Game < ApplicationRecord
  belongs_to :user, optional: true # Set USER_key as OPTIONAL
  has_many :rounds
end
