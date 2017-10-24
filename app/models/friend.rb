class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: User.name, foreign_key: :friend_id
  scope :friend_accept, ->{joins(:friend).where("friends.status = ?", Settings.friend.request)}
  scope :list_friends, ->{where("friends.status = ?", Settings.friend.accept)}
end
