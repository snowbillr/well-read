class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :total_pages
      t.integer :current_page, default: 0
      t.string :isbn
      t.string :status, default: "want_to_read"
      t.integer :rating
      t.text :review_text
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
