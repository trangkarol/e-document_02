class Document < ApplicationRecord
  has_many :likes, as: :likable, dependent: :destroy
  # User create documents
  belongs_to :owner, dependent: :destroy, source: :users
  # Management history download, upload of users
  has_many :histories, dependent: :destroy
  has_many :users, through: :histories
  # Comment
  has_many :comments, dependent: :destroy
  # Category of document
  has_many :category_documents, dependent: :destroy
  has_many :categories, through: :category_documents
end
