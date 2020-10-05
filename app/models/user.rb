class User < ApplicationRecord
  has_one :house, :dependent => :destroy
  has_many :housing_advert, :dependent => :destroy
  has_many :housing_reservations, :dependent => :destroy
  has_many :housing_adverts, :through => :housing_reservations
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  validates :tel, format: { with: /[0-9]+/, message: "only allows numbers" }
end