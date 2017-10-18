class CreateCategoryDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :category_documents do |t|
      t.references :categorie, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
