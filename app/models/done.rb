class Done < ApplicationRecord   
	serialize :respostas, Array   
	belongs_to :student
	belongs_to :exam

	validate :validate_this

	private

	def validate_this
		@errors = ActiveModel::Errors.new(self)
		if Done.where(exam_id: self.exam.id, student_id: self.student.id).any?
			errors.add(:base,I18n.t("error.exam_already_exists"))
		end
	end
end
