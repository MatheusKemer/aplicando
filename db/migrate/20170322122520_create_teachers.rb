class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.text :nome

      t.timestamps
    end
  end
end
