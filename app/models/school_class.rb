class SchoolClass < ApplicationRecord
	#has_many :students
	has_many :disciplines, optional: true

	validates :ano, presence: {message: "é necessário"},
	uniqueness: true

  #validate :one_discipline
  #before_adding_discipline

	#validates :teacher_id, presence: {message: "é preciso ter um"

end
