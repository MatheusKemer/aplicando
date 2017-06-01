class CreateDisciplines < ActiveRecord::Migration[5.0]
  def change
    create_table :disciplines do |t|
      t.string :name
      t.references :teacher
      t.references :school_class

      t.timestamps
    end
  end
end
