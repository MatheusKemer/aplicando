class CreateProfessors < ActiveRecord::Migration[5.0]
  def change
    create_table :professors do |t|
      t.text :nome

      t.timestamps
    end
  end
end
