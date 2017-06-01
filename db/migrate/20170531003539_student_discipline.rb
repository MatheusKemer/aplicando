class CreateStudentDiscipline < ActiveRecord::Migration[5.0]
  def change
    create_table :student_discipline, :id => false do |t|
      t.integer :discipline_id
      t.integer :student_id
    end
  end
end
