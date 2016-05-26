require 'carrierwave/orm/activerecord'
class Section < ActiveRecord::Base
  belongs_to :lesson

  validates :description, presence: true
  validates :lesson_id, presence: true

  mount_uploader :audio, AvatarUploader

end
