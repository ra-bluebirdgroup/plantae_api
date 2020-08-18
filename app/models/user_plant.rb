class UserPlant < ApplicationRecord
  belongs_to :plant
  belongs_to :user

validates :plant_id, uniqueness: true
end
