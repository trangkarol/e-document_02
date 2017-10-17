class User < ApplicationRecord
  # List friends
  has_many :firends, dependent: :destroy
  # Management payments coins
  has_many :payments, dependent: :destroy
  has_many :coins, through: :payments
  # User Like
  has_many :likes, as: :likable, dependent: :destroy
  # Manegement history download, upload document of user
  has_many :histories, dependent: :destroy
  has_many :histories_documents, through: :histories, source: :documents
  # User comment document
  has_many :comments, dependent: :destroy
  has_many :comment_documents, through: :comments, source: :documents
  # List of documents that user is favorites
  has_many :favorites, dependent: :destroy
  has_many :favority_documents, through: :comments, source: :documents
end
