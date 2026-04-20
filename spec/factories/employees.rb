FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    job_title { Faker::Job.title }
    country { Faker::Address.country }
    salary { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
