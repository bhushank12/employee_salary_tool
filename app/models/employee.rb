class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :job_title, :country, :salary, :phone_number, presence: true
  validates :salary, numericality: { greater_than: 0 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
