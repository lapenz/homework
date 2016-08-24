class CreateUsersSections < ActiveRecord::Migration
  def change
    create_table :users_sections do |t|
      t.integer :user_id
      t.integer :section_id

      t.timestamps null: false
    end
  end
end
