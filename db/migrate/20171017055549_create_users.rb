class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.string :address
      t.string :phone
      # t.string :password_digest
      t.boolean :status, default: 0
      t.string :avatar
      t.boolean :role, default: 1
      t.integer :total_coin, default: 0
      t.integer :number_free, default: 3
      t.integer :number_upload, default: 0

      t.timestamps
    end
  end
end
