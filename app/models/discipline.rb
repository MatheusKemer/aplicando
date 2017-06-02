class Discipline < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_class
  has_many :questions
  has_many :exams
  #has_many :students

  serialize :students

  validates :name, presence: {message: "é necessário"}, uniqueness: true
  #validate :duplicate_students

  #validates :teacher_id, presence: {message: "é preciso ter um"}

  #validates :school_class_id, presence: {message: "é preciso ter um"}
  def duplicate_students
    errors.add(:discipline, "já existe aluno") if self.students.include?
  end

  def add_students (eae)
    if self.students.include? eae
      errors.add(:discipline, "já existe esse aluno")
      false
    else
      self.students << eae
      true
    end
  end

end
