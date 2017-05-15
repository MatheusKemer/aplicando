class Exam < ApplicationRecord
	belongs_to :teacher, optional: true
	has_and_belongs_to_many :questions
	has_and_belongs_to_many :students, :uniq => true, :before_add => :before_adding_students
	has_many :dones
	belongs_to :turma, optional: true

	validates_presence_of :turma
	validates_presence_of :teacher

	private
	def before_adding_students(student)
		if self.turma_id == student.turma_id
			self.students.each do |s|
				if s.id == student.id
					errors.add(:exams, "Já existe esse aluno na prova")
					return
				end
			end
		else
			return
		end
	end
end
