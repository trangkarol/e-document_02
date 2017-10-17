class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.integer :number_coins
      t.float :cost

      t.timestamps
    end
  end
end
