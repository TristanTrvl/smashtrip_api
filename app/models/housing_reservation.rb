class HousingReservation < ApplicationRecord
  belongs_to :user
  belongs_to :housing_advert
  enum status: {
    pending: 'pending', 
    validated: 'validated', 
    refused: 'refused'
  }
end
