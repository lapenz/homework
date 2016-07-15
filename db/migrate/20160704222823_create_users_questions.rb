class CreateUsersQuestions < ActiveRecord::Migration
  def change
    create_table :users_questions do |t|
      t.integer :user_id, :limit => 3
      t.integer :question_id, :limit => 3
      t.string :description
      t.boolean :right

      t.timestamps null: false
    end

    add_index :users_questions, :user_id
    add_index :users_questions, :question_id
  end
end
