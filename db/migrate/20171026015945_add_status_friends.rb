class AddStatusFriends < ActiveRecord::Migration[5.1]
  def change
    add_column :friends, :status, :integer, default: 0
  end
end
