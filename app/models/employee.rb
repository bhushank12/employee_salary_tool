class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :job_title, :country, :salary, :phone_number, presence: true
end
