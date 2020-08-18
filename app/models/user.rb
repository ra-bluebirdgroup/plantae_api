class User < ApplicationRecord
  has_secure_password

  has_many :user_plants
  has_many :plants, through: :user_plants

  has_many :plant_user_comments

validates :username, presence: true
validates :username, uniqueness: true
validates :password, presence: true, length: { minimum: 6 }

end
