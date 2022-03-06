class AddCommunicateWithToBooth < ActiveRecord::Migration[6.1]
  def change
    add_column :booths, :communicate_with, :string
    add_column :booths, :string, :string
  end
end
