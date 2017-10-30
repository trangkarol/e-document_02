class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user
  scope :check_exit, ->(user_id, document_id){where("user_id = ? AND likable_id = ?", user_id, document_id)}
  scope :check_like, ->(user_id){where("user_id = ?", user_id)}
end
