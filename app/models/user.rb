class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.teacher?
    current_user.type == "Teacher"
  end

  def student?
    current_user.type == "Student"
  end
end
