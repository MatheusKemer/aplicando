class AddNotaToDone < ActiveRecord::Migration[5.0]
  def change
    add_column :dones, :nota, :float
  end
end
