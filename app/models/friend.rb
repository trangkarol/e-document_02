class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: User.name, foreign_key: :friend_id
  scope :friend_accept, lambda{|current_user_id|
    joins(:user).where("friends.status = ?", Settings.friend.request).where("friends.friend_id = ?", current_user_id)
  }
  scope :list_friends, lambda{|user_id|
    joins(:friend).where("friends.status = ?", Settings.friend.accept).where("friends.user_id = ? OR friends.friend_id = ?", user_id, user_id)
  }
  scope :check_friend, lambda{|status, user_id, current_user_id|
   where("friends.status = ?", status).where("(friends.user_id = ? AND friends.friend_id = ?)OR (friends.friend_id = ? AND friends.user_id = ?)", user_id, current_user_id, user_id, current_user_id)
  }
  def accpet_request
    update_attribute :status, Settings.friend.accept
  end
end
