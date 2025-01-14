class AddBorrowerIdToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :borrower_id, :integer
  end
end
