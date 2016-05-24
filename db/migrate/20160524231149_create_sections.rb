class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :lesson_id
      t.string :description
      t.string :audio

      t.timestamps null: false
    end

    add_index :sections, :lesson_id
  end
end
