class AlterNumberQuestionType < ActiveRecord::Migration
  def change
    def self.up
      change_table :questions do |t|
        t.change :number, :integer
      end
    end
    def self.down
      change_table :questions do |t|
        t.change :price, :string
      end
    end
  end
end
