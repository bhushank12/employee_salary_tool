# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Seeding employees..."
first_names = File.readlines(Rails.root.join('db/first_names.txt'), chomp: true)
last_names  = File.readlines(Rails.root.join('db/last_names.txt'), chomp: true)

BATCH_SIZE = 200
TOTAL_RECORDS = 10000

raise "Not enough names in files" if first_names.size < TOTAL_RECORDS || last_names.size < TOTAL_RECORDS

job_titles = %w[Engineer Manager Analyst]
countries  = %w[India USA UK]

TOTAL_RECORDS.times.each_slice(BATCH_SIZE) do |batch|
  employees = []

  batch.each do |i|
    first_name = first_names[i]
    last_name = last_names[i]

    employees << {
      first_name: first_name,
      last_name: last_name,
      job_title: job_titles.sample,
      country: countries.sample,
      salary: rand(30000..150000),
      email: "#{first_name.downcase}.#{last_name.downcase}.#{i}@example.com",
      phone_number: Faker::PhoneNumber.phone_number,
      created_at: Time.current,
      updated_at: Time.current
    }
  end

  Employee.insert_all(employees)
  puts "Inserted #{batch.last + 1} employees"
end

puts "Seeded #{TOTAL_RECORDS} employees successfully!"