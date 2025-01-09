class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author
      t.date :published_date
      t.integer :quantity, default: 0

      t.timestamps
    end
  end
end
