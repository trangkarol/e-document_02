class History < ApplicationRecord
  belongs_to :user
  belongs_to :document
  default_scope ->{order(created_at: :desc)}
  scope :list_histories, ->{joins(:document)}
  scope :list_histories_statistic, ->(name_action){joins(:user).where("name_action like ?", name_action)}

  class << self
    def check_exit(document_id, user_id, name_action)
      where("document_id = ? AND user_id = ? AND name_action like ?", document_id, user_id, name_action)
    end
  end

  def update_number
    update_attribute :number, self.number += 1
  end
end
