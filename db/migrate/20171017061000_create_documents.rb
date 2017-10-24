class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :number_download
      t.string :file
      t.integer :size
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
