class RemoveIsbnFromBooks < ActiveRecord::Migration[8.1]
  def change
    remove_column :books, :isbn, :string
  end
end
