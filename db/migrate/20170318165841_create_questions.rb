class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
     create_table :questions do |t|
        t.string :pergunta
        t.integer :correct
        t.boolean :visible
        t.references :professor	
   
        t.timestamps null: false
      end
  end
end
