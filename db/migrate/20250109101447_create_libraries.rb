class CreateLibraries < ActiveRecord::Migration[7.0]
  def change
    create_table :libraries do |t|
      t.string :name, null: false
      t.string :location

      t.timestamps
    end
  end
end
