class Dislike < ApplicationRecord
	belongs_to :teacher
	belongs_to :question

	validate :add_dislike

	after_destroy :remove_dislike

	def remove_dislike
		question = Question.find question_id
		question.dislikes = question.dislikes - 1
		question.save!
	end

	private

	def add_dislike
		if self.teacher_id == self.question.teacher_id
			errors.add(:base, I18n.t("error.cannot_dislike_own_question"))
			return
		end
		question = Question.find(self.question_id)
		if Dislike.where(teacher_id: self.teacher_id, question_id: self.question_id).any?
			errors.add(:base, I18n.t("error.already_disliked_it"))
			return
		elsif Like.where(teacher_id: self.teacher_id, question_id: self.question_id).any?
			Like.where(teacher_id: self.teacher_id, question_id: self.question_id).first.destroy
			question.likes -= 1
			dislike(question)
		else
			dislike(question)
		end
	end

	def dislike(question)
		if question.dislikes.nil?
			question.dislikes = 1
		else
			question.dislikes = question.dislikes + 1
		end
		question.save
	end
end
