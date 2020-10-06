class House < ApplicationRecord
  belongs_to :user
  has_many :houses_has_convenience, :dependent => :destroy
  has_many :conveniences, :through => :houses_has_convenience
end
