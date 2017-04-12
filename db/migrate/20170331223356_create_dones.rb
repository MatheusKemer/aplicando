class CreateDones < ActiveRecord::Migration[5.0]
  def change
    create_table :dones do |t|
      t.text :respostas
      t.references :students
      t.references :exam
      t.timestamps
    end
  end
end
