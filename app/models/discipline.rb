class Discipline < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_class
  has_many :questions
  has_many :exams
  #has_many :students

  serialize :students

  validates :name, presence: {message: I18n.t("discipline.error.name")}, uniqueness: true
  #validate :duplicate_students

  #validates :teacher_id, presence: {message: "é preciso ter um"}

  #validates :school_class_id, presence: {message: "é preciso ter um"}
  def duplicate_students
    errors.add(:discipline, "já existe aluno") if self.students.include?
  end

  def add_students (eae)
    @discipline = self
    #eae.try(:count) ? : eae = [eae]
    self.students = [] if self.students.nil?
    unless eae.try(:count).nil?
      eae.each do |s|
        if self.students.include? s
          return I18n.t("discipline.error.already_students", student: s.name)
        else
          @discipline.students = @discipline.students + s
        end
      end
    else
      if self.students.include? eae
        return I18n.t("discipline.error.already_students", student: eae.name)
      else
        @discipline.students << eae
      end
    end
    @discipline.save
  end
end
