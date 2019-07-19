class Game < ApplicationRecord
  belongs_to :user, optional: true # Set USER_key as OPTIONAL
  has_many   :rounds, dependent: :destroy

  accepts_nested_attributes_for :rounds,
    allow_destroy: true,
    reject_if: :all_blank
    # reject_if: proc { |att| att["name"].blank? }
end
