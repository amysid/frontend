class AddKeyToStores < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :model_type, :string
  end
end
