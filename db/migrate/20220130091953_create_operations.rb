class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations do |t|
      t.integer :number
      t.string  :listening_status
      t.datetime  :listening_time
      t.string :rating
      t.string :note
      t.references :book 
      t.references :booth 

      t.timestamps
    end
  end
end
