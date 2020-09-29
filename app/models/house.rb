class House < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  validates :nb_slots, format: { with: /[0-9]+/, message: "only allows numbers" }
end
