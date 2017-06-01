class Teacher < User
	has_many :questions
	has_many :exams
	has_many :disciplines

	def likeds
		Like.where(teacher_id: self.id)
	end

	def dislikeds
		Dislike.where(teacher_id: self.id)
	end
end
