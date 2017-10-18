class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :firend, class_name: "User", foreign_key: :friend_id
end
