class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.references :user, foreign_key: true
      t.references :document, foreign_key: true
      t.string :name_action

      t.timestamps
    end
  end
end
