class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :job_title
      t.string :country
      t.decimal :salary
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
