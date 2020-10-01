class HousesHasConvenience < ApplicationRecord
  belongs_to :house
  belongs_to :convenience
end
