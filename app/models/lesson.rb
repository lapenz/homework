class Lesson < ActiveRecord::Base
  belongs_to :book
  has_many :sections, :dependent => :destroy

  validates :description, presence: true
  validates :book_id, presence: true


  def description_detailed
    self.book.description + ' - ' + description
  end

end
