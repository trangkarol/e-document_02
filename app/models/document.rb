class Document < ApplicationRecord
  has_many :likes, as: :likable
  # User create documents
  belongs_to :owner, class_name: User.name, foreign_key: :user_id
  belongs_to :category
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
  scope :search_document, ->(search){where("name like ? OR description like ?", "%#{search}%", "%#{search}%")}

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader

  validates :name,
    presence: true,
    length: {minimum: Settings.document.name_length, maximum: Settings.document.name_max_length}
  validates :description,
    presence: true,
    length: {minimum: Settings.document.description_length}
  validates :file, presence: true
  validates :category_id, presence: true

  before_save :update_asset_attributes

  def update_number_of_like flag
    number_of_like = self.number_of_like
    if flag == Settings.like.flag_like
      number_of_like += 1
    else
      number_of_like -= 1
    end
    update_attribute :number_of_like, number_of_like
  end

  def check_like_document current_user_id
    likes.check_like(current_user_id).empty?
  end

  def update_number_download
    self.number_download += 1
    update_attribute :number_download, self.number_download
  end

  def update_number_of_comment
    update_attribute :number_of_comment, self.number_of_comment += 1
  end

  private

  def update_asset_attributes
    if file.present? && file_changed?
      self.content_type = file.file.content_type
    end
  end
end
