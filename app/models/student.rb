class Student < User
	#has_many :exams, :through => :exams_users
	#belongs_to :discipline
	has_many :dones
	before_save :check_student

	validates :name, presence: {message: "não pode ficar em branco"}
	#validates :class_id, presence: {message: "é preciso ter uma class"}

  def disciplines
    Discipline.all.map {|d| d if !d.students.blank? && (d.students.include? Student.first)}.compact
  end

  private

  def check_student
	end
end
