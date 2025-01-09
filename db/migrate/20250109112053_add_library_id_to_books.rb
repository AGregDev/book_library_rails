class AddLibraryIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :books, :library, null: false, foreign_key: true
  end
end
