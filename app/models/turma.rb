class Turma < ApplicationRecord
	has_many :students
	belongs_to :teacher, optional: true
	has_many :exams

	validates :ano, presence: {message: "ano é necessário"},
	uniqueness: true

	validates :teacher_id, presence: {message: "é preciso ter um professor"}
end
