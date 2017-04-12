class Turma < ApplicationRecord
	has_many :students
	belongs_to :professor, optional: true
	has_many :exams

	validates :ano, presence: {message: "ano é necessário"},
	uniqueness: true

	validates :professor_id, presence: {message: "é preciso ter um professor"}
end
