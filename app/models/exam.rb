class Exam < ApplicationRecord
	belongs_to :professor, optional: true
	has_and_belongs_to_many :questions
	has_and_belongs_to_many :students, :uniq => true, :before_add => :before_adding_students
	has_many :dones
	belongs_to :turma, optional: true
	

	private
	def before_adding_students(student)
		 
		errors.add(:exams, "Já existe um aluno nessa prova")
		if self.turma_id == student.turma_id
			self.students.each do |s|
				if s.id == student.id		
					errors.add(:exams, "Já existe um aluno nessa prova")
					return
				end
			end
		else
			return
		end
	end
end
