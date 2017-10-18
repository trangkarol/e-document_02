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
  # Create document
  has_many :documents, dependent: :destroy

  def check_coin?
    total_coin > Settings.user.minimum_coin
  end

  def number_free?
    number_free > Settings.user.minimum_number_free
  end

  # Check
  def check_upload?
    number_upload <= Settings.user.maxnimum_number_dowload
  end

  # Update number_upload default of user
  def update_number_upload
    return unless check_upload?
    update_attribute :number_upload, number_upload + Settings.user.add_number_upload
  end

  # When user download document that number_tree > 3
  def update_number_free
    return unless number_free?
    update_attribute :number_free, number_free - Settings.user.minus_number_free
  end

  # Update total coin when upload and buy coin
  def update_total_coins total_coin = Settings.user.default_total_coin
    if total_coin && check_coin? && !number_free?
      total_coin -= Settings.user.minus_total_coin
    end
    update_attribute :total_coin, total_coin
  end
end
