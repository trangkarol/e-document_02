class Coin < ApplicationRecord
  has_many :payments, dependent: :destroy
  has_many :users, through: :payments, dependent: :destroy
end
