require 'carrierwave/orm/activerecord'
class Section < ActiveRecord::Base
  belongs_to :lesson
  has_many :questions
  has_many :users_sections

  validates :description, presence: true
  validates :lesson_id, presence: true

  mount_uploader :audio, AvatarUploader

  def description_detailed
    self.lesson.description_detailed + ' - ' + description
  end
end
