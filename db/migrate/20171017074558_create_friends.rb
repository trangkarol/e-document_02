class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end
    add_index :friends, :user_id
    add_index :friends, :friend_id
    add_index :friends, [:user_id, :friend_id], unique: true
  end
end
