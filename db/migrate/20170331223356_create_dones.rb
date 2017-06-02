class CreateDones < ActiveRecord::Migration[5.0]
  def change
    create_table :dones do |t|
      t.references :student, :null => false
      t.references :exam, :null => false
      t.text :respostas
      t.datetime :finished_at, :null => false
    end
  end
end
