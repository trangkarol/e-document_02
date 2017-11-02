class History < ApplicationRecord
  belongs_to :user
  belongs_to :document
  scope :list_histories, ->{joins(:document)}
end
