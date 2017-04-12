class Professor < User
	has_many :questions
	has_many :exams
	has_many :turmas
end
