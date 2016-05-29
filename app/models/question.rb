class Question < ActiveRecord::Base
  belongs_to :section

  validates :description, presence: true
  validates :section_id, presence: true

end
