class CreateSchoolClasses < ActiveRecord::Migration[5.0]
  def change
    create_table :school_classes do |t|
      t.integer :ano
      #t.references :teacher

      t.timestamps
    end
  end
end
