class AddIndexesToEmployees < ActiveRecord::Migration[8.0]
  def change
    add_index :employees, :email, unique: true
    add_index :employees, :country
    add_index :employees, [:country, :salary]
  end
end
