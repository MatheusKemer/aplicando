class CreateAnswers < ActiveRecord::Migration
    def change
      create_table :answers do |t|
        t.string :resposta
        t.references :question

        t.timestamps null: false
      end
    end
end
