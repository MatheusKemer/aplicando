class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.string :title
      t.references :discipline
      t.references :teacher

      t.timestamps
    end
  end
end
