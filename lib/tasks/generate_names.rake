require 'faker'

namespace :db do
  desc "Generate first_names.txt and last_names.txt using Faker"
  task generate_names: :environment do
    first_names = 10000.times.map { Faker::Name.first_name }
    last_names  = 10000.times.map { Faker::Name.last_name }

    File.write(Rails.root.join('db/first_names.txt'), first_names.join("\n"))
    File.write(Rails.root.join('db/last_names.txt'), last_names.join("\n"))

    puts "Generated #{first_names.size} first names and #{last_names.size} last names"
  end
end
