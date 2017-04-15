class Answer < ApplicationRecord
	#has_many :questions	
	belongs_to :question
	#before_save :add_question
	
	def add_question
		Question.find(Answer.last.question_id).update answer_id: Answer.last.id    
	end
end
