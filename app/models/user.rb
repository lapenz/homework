class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[admin student].freeze

  def email_required?
    false
  end

  def admin?
    self.role == "admin"
  end
  def student?
    self.role == "student"
  end
end
