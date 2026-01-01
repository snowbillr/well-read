class CreateReadingSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :reading_sessions do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :duration_seconds
      t.integer :pages_read
      t.datetime :start_time

      t.timestamps
    end
  end
end
