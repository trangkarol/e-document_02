class Document < ApplicationRecord
  has_many :likes, as: :likable, dependent: :destroy
  # User create documents
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  # Management history download, upload of users
  has_many :histories, dependent: :destroy
  has_many :users, through: :histories
  # Comment
  has_many :comments, dependent: :destroy
  # Category of document
  has_many :category_documents, dependent: :destroy
  has_many :categories, through: :category_documents

  validates :description , presence: true, length: {minimum: Settings.document.description_length}, allow_nil: true
end
