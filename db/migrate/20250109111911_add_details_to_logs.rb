class AddDetailsToLogs < ActiveRecord::Migration[7.2]
  def change
    add_column :logs, :details, :string
  end
end
