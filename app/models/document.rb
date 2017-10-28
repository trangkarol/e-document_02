class Document < ApplicationRecord
  has_many :likes, as: :likable
  # User create documents
  belongs_to :owner, class_name: User.name, foreign_key: :user_id
  # Management history download, upload of users
  has_many :histories, dependent: :destroy
  has_many :users, through: :histories
  # Comment
  has_many :comments, dependent: :destroy
  # Category of document
  has_many :category_documents, dependent: :destroy
  has_many :categories, through: :category_documents
  has_many :favorites, dependent: :destroy

  default_scope ->{order(created_at: :desc)}

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  validates :name,
    presence: true,
    length: {minimum: Settings.document.name_length, maximum: Settings.document.name_max_length}
  validates :description,
    presence: true,
    length: {minimum: Settings.document.description_length}
  validates :image, presence: true
  validates :file, presence: true
end
