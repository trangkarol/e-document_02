class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true
  belongs_to :user
  scope :check_exit, ->(current_user_id, document_id){ where("user_id = ? AND likable_id = ?", current_user_id, document_id)}
  scope :check_like, ->(current_user_id){where("user_id = ?", current_user_id)}
  scope :list_user, -> {joins(:user)}
end
