class History < ApplicationRecord
  belongs_to :user
  belongs_to :document
  default_scope ->{order(created_at: :desc)}
  scope :list_histories, ->{joins(:document)}
end
