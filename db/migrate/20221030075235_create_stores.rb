class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :ref_id
      t.string :model_type
      
      t.timestamps
    end
  end
end
