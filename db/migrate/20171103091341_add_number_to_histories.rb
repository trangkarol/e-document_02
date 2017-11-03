class AddNumberToHistories < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :number, :integer, default: 1
  end
end
