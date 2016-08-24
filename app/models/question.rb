class Question < ActiveRecord::Base
  belongs_to :section
  has_many :users_questions

  validates :description, presence: true
  validates :section_id, presence: true

end
