class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.datetime :birthday
      t.string :address
      t.string :phone
      t.string :password_digest
      t.boolean :status
      t.string :avatar
      t.boolean :role
      t.integer :total_coin
      t.integer :number_free
      t.integer :number_upload

      t.timestamps
    end
  end
end
