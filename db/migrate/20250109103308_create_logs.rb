class CreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, foreign_key: true
      t.string :action, null: false
      t.text :description

      t.timestamps
    end
  end
end
