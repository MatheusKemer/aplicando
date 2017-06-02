class AddStudentsToDiscipline < ActiveRecord::Migration[5.0]
  def change
    add_column :disciplines, :students, :text, array: true
  end
end
