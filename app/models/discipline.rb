class Discipline < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_class
  has_many :questions
  has_many :exams
  has_many :students

  validates :name, presence: {message: "é necessário"}, uniqueness: true
 # validate :before_adding_discipline

  #validates :teacher_id, presence: {message: "é preciso ter um"}

  #validates :school_class_id, presence: {message: "é preciso ter um"}
  def before_adding_discipline
    errors.add(:discipline, "já existe") if Discipline.all.map{|a| a.name }.include? self.name
  end

end
