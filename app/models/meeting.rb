class Meeting < ApplicationRecord
  has_many :matchings, dependent: :destroy
  has_many :groups, through: :matchings

  has_many :users, through: :groups
end
