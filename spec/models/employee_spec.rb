require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { build(:employee) }

  it 'is valid with valid attributes' do
    expect(employee).to be_valid
  end

  it 'is invalid without a first name' do
    employee.first_name = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without a last name' do
    employee.last_name = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without an email' do
    employee.email = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without a job title' do
    employee.job_title = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without a country' do
    employee.country = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without a salary' do
    employee.salary = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid without a phone number' do
    employee.phone_number = nil
    expect(employee).not_to be_valid
  end

  it 'is invalid if salary is less than or equal to 0' do
    employee.salary = 0
    expect(employee).not_to be_valid
  end

  it 'is invalid if salary is not a number' do
    employee.salary = 'not_a_number'
    expect(employee).not_to be_valid
  end

  it 'return full name correctly' do
    expect(employee.full_name).to eq("#{employee.first_name} #{employee.last_name}")
  end
end
