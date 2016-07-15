class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :section_id
      t.string :description
      t.string :number
      t.string :sequence
      t.text :intro

      t.timestamps null: false
    end

    add_index :questions, :section_id
  end
end
