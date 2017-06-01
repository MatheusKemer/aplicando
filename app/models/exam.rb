class Exam < ApplicationRecord
	belongs_to :teacher, optional: true
	has_and_belongs_to_many :questions
	#has_many :students,  :through => :exams_users#, :uniq => true
	#, :class_name => "Student",:foreign_key => 'user_id'#, :before_add => :before_adding_students
	#association_foreign_key: 'section_id', join_table: 'products_sections'
	#:class_name => "Student",:foreign_key => 'user_id'
	has_many :dones
	belongs_to :discipline, optional: false

	validates_presence_of :teacher
	validates_presence_of :title

	validate :presence_of_questions

	private

	def presence_of_questions
		errors.add(:exams, "Sem questão") if self.questions.empty?
	end

	def before_adding_students(student)
		if self.class_id == student.class_id
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
