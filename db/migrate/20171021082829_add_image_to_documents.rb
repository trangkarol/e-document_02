class AddImageToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :image, :string
  end
end
