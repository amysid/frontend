class AddLastListenTimeToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :last_listening_at, :datetime
  end
end
