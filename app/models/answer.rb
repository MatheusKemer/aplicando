class Answer < ApplicationRecord
	#has_many :questions	
	belongs_to :questions, optional: true
	#before_save :add_question
	
	def add_question
		Question.find(Answer.last.question_id).update answer_id: Answer.last.id    
	end
end
