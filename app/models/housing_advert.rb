class HousingAdvert < ApplicationRecord
  belongs_to :user
  has_many :housing_reservations, :dependent => :destroy
  has_many :users, :through => :housing_reservations
end
