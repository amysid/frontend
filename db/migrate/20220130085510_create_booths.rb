class CreateBooths < ActiveRecord::Migration[6.1]
  def change
    create_table :booths do |t|
      t.string :number, index: true
      t.string :name
      t.string :city
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :location
      t.string :phone_number
      t.integer :listening_count,  default: 0
      
      t.timestamps
    end
  end
end
