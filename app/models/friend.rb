class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: User.name, foreign_key: :friend_id
  scope :friend_accept, lambda{|current_user_id|
    joins(:user).where("friends.status = ? AND friends.friend_id = ?", Settings.friend.request, current_user_id)
  }
  scope :list_friends, lambda{|user_id|
    joins(:friend).where("friends.status =  ?", Settings.friend.accept)
                  .where("friends.user_id = ? OR friends.friend_id = ?", user_id, user_id)
  }
  scope :check_friend, ->(member_id){where("friend_id= ?", member_id)}
  scope :status_request, ->{where("friends.status = ?", Settings.friend.request)}

  def accpet_request
    update_attribute :status, Settings.friend.accpet
  end
end
