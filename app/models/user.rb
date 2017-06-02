class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def teacher?
    self.type == "Teacher"
  end

  def student?
    self.type == "Student"
  end

  def admin?
    self.type == "Admin"
  end
end
