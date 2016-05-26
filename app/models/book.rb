class Book < ActiveRecord::Base
  has_many :lessons, :dependent => :destroy
  validates :description, presence: true

end
