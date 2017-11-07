class User < ApplicationRecord
  # List friends
  has_many :friends, dependent: :destroy
  has_many :request, class_name: Friend.name, foreign_key: "friend_id", dependent: :destroy
  # Management payments coins
  has_many :payments, dependent: :destroy
  has_many :coins, through: :payments
  # User Like
  has_many :likes, as: :likable, dependent: :destroy
  # Manegement history download, upload document of user
  has_many :histories, dependent: :destroy
  has_one :histories_documents, through: :histories, source: :documents
  # User comment document
  has_many :comments, dependent: :destroy
  has_many :comment_documents, through: :comments, source: :documents
  # List of documents that user is favorites
  has_many :favorites, dependent: :destroy
  has_many :favority_documents, through: :comments, source: :documents
  # Create document
  has_many :documents, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  # Validates
  validates :name, presence: true, length: {maximum: Settings.user.name_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email_length},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password_length}, allow_nil: true
  scope :friends_request, lambda{|current_user_id, firend_ids|
    where("id NOT IN (?) AND id != ?", firend_ids, user_id)
  }
  scope :not_user, ->(user_id){where("id != ?", user_id)}
  scope :search_user, ->(search){where("name like ? OR email like ?", "%#{search}%", "%#{search}%")}
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

  def check_download?
    number_free? || check_coin?
  end

  # Update number_upload default of user
  def update_number_upload
    return unless check_upload?
    update_attribute :number_upload, number_upload + Settings.user.add_number_upload
  end

  def update_number_download
    if number_free?
      update_number_free
    elsif check_coin?
      update_attribute :total_coin, self.total_coin += Settings.user.minus_total_coin
    end
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

  def update_buy_coin number_coins
    self.total_coin += number_coins
    update_attribute :total_coin, self.total_coin

  end

  # Returns true if the given token matches the digest.
  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def list_friends
    friend_ids = friends.joins(:friend).where("friends.status = ?", Settings.friend.accept)
    request_ids = request.joins(:user).where("friends.status = ?", Settings.friend.accept)
    friend_ids + request_ids
  end

  def list_history_docuement
    histories.list_histories
  end
end
