class UsersQuestion < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :question

  def self.update_or_create(attributes)
    assign_or_new(attributes).save
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end
