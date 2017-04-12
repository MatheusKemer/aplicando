class CreateJoinTableStudentExam < ActiveRecord::Migration[5.0]
  def change
    create_join_table :students, :exams do |t|
      # t.index [:aluno_id, :exam_id]
      # t.index [:exam_id, :aluno_id]
    end
  end
end
