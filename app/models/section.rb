require 'carrierwave/orm/activerecord'
class Section < ActiveRecord::Base
  default_scope { includes(:lesson).order("lessons.book_id asc, lessons.description asc") }

  belongs_to :lesson
  has_many :questions
  has_many :users_sections

  validates :description, presence: true
  validates :lesson_id, presence: true

  mount_uploader :audio, AvatarUploader
  mount_uploader :second_audio, AvatarUploader

  def description_detailed
    self.lesson.description_detailed + ' - ' + description
  end
end
