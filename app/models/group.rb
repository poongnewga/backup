class Group < ApplicationRecord
  has_many :matchings, dependent: :destroy
  has_many :meetings, through: :matchings

  has_many :joins, dependent: :destroy
  has_many :users, through: :joins
end
