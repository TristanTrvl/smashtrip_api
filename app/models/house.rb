class House < ApplicationRecord
  belongs_to :user
  has_many :houses_has_convenience, :dependent => :destroy
  has_many :conveniences, :through => :houses_has_convenience
  validates :address, presence: true
  validates :nb_slots, format: { with: /[0-9]+/, message: "only allows numbers" }
end
