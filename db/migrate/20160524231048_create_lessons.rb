class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :book_id
      t.string :description

      t.timestamps null: false
    end

    add_index :lessons, :book_id
  end
end
