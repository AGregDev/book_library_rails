class AddBookIdToBookCategories < ActiveRecord::Migration[7.2]
  def change
    add_reference :book_categories, :book, null: false, foreign_key: true
  end
end
