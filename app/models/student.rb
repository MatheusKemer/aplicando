class Student < ApplicationRecord
	has_and_belongs_to_many :exams
	belongs_to :turma, optional: true
	has_many :dones
	before_save :check_student

	validates :name, presence: {message: "não pode ficar em branco"}
	validates :turma_id, presence: {message: "é preciso ter uma turma"}
	private
	def check_student
		 
	end
end
