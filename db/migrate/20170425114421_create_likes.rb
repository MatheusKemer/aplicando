class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :question, :null => false
      t.references :teacher, :null => false
      t.timestamps
    end
  end
end
