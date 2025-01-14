class AddBorroweredAtBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :borrowered_at, :timestamp
  end
end
