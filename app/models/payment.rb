class Payment < ApplicationRecord
  belongs_to :users
  belongs_to :coins
end
