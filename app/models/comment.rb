class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  has_many :likes, as: :likable, dependent: :destroy
  delegate :name, to: :user, prefix: true
  delegate :avatar, to: :user, prefix: true
end
