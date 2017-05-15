class Like < ApplicationRecord
	belongs_to :teacher
	belongs_to :question
	after_destroy :remove_like

	validate :add_like

	def remove_like
		question = Question.find question_id
		question.likes = question.likes - 1
		question.save!
	end

	private

	def add_like
		if self.teacher_id == self.question.teacher_id
			errors.add(:base, I18n.t("error.cannot_like_own_question"))
			return
		end
		question = Question.find(self.question_id)
		if Like.where(teacher_id: self.teacher_id, question_id: self.question_id).any?
			errors.add(:base, I18n.t("error.already_liked_it"))
			return
		elsif Dislike.where(teacher_id: self.teacher_id, question_id: self.question_id).any?
			Dislike.where(teacher_id: self.teacher_id, question_id: self.question_id).first.delete
			question.dislikes -= 1
			like(question)
		else
			like(question)
		end
	end

	def like(question)
		if question.likes.nil?
			question.likes = 1
		else
			question.likes = question.likes + 1
		end
		question.save
	end
end
