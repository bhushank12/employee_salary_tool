class Employee < ApplicationRecord
  validates :first_name, :last_name, :email, :job_title, :country, :salary, :phone_number, presence: true
  validates :salary, numericality: { greater_than: 0 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone_number, format: { with: /\A\+?[0-9]{10,15}\z/, message: "must be a valid phone number" }

  def full_name
    "#{first_name} #{last_name}"
  end
end
