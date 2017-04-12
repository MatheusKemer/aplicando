class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.text :name
      t.references :turma

      t.timestamps
    end
  end
end
