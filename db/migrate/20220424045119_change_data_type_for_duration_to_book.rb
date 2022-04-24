class ChangeDataTypeForDurationToBook < ActiveRecord::Migration[6.1]
  def up
    change_column :books, :book_duration, :decimal
  end

  def down
    change_column :books, :book_duration, :integer
  end
end
