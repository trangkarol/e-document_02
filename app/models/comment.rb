class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :likes, as: :likable, dependent: :destroy
end
