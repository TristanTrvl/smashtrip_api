class Convenience < ApplicationRecord
  has_many :houses_has_convenience
  has_many :houses, :through => :houses_has_convenience
end
