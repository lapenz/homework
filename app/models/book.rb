class Book < ActiveRecord::Base
  default_scope { order(id: :asc) }
  has_many :lessons, :dependent => :destroy
  validates :description, presence: true

end
