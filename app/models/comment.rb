class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  scope :order_comment, ->{order(created_at: :desc)}
  has_many :likes, as: :likable, dependent: :destroy
end
