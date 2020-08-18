class Plant < ApplicationRecord
  has_many :user_plants
has_many :users, through: :user_plants

has_many :plant_user_comments
has_many :users, through: :plant_user_comments

validates :scientific_name, presence: true
validates :scientific_name, uniqueness: true
end
