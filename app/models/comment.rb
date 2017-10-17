class Comment < ApplicationRecord
  belongs_to :users
  belongs_to :documents
  has_many :likes, as: :likable
end
