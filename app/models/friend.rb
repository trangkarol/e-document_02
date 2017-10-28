class Friend < ApplicationRecord
  belongs_to :user
  scope :friend_accept, lambda{|current_user_id|
    joins(:user).where("friends.status = ?", Settings.friend.request).where("friends.friend_id = ?", current_user_id)
  }
  scope :list_friends, lambda{|user_id|
    joins(:friend).where("friends.status = ?", Settings.friend.accept).where("friends.user_id = ?", user_id)
  }
  scope :check_friend, ->(member_id){where("friend_id= ?", member_id)}

  def accpet_request
    update_attribute :status, Settings.friend.accpet_request
  end
end
