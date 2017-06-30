class AddIndexToUsersQuestions < ActiveRecord::Migration
  def change
    add_index :users_questions, [:user_id, :question_id], unique: true
  end
end
