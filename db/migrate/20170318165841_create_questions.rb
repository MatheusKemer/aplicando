class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
     create_table :questions do |t|
        t.string :pergunta
        t.string :correct
        t.string :answers
        t.boolean :visible, default: true
        t.references :teacher
        t.references :discipline
   			t.integer :likes
   			t.integer :dislikes
        t.timestamps null: false
      end
  end
end
