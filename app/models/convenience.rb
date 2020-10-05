class Convenience < ApplicationRecord
  has_many :houses_has_convenience, :dependent => :destroy
  has_many :houses, :through => :houses_has_convenience
  validates :name, presence:true, uniqueness: true
end
