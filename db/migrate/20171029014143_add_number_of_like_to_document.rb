class AddNumberOfLikeToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :number_of_like, :integer, default: 0
  end
end
