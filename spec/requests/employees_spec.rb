require 'swagger_helper'

RSpec.describe 'Employees API', type: :request do
  path '/employees' do
    post 'Create an employee' do
      tags 'Employees'
      consumes 'application/json'
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string, example: 'John' },
          last_name: { type: :string, example: 'Doe' },
          job_title: { type: :string, example: 'Software Engineer' },
          country: { type: :string, example: 'USA' },
          salary: { type: :number, format: :float, example: 75000.00 },
          email: { type: :string, example: 'john@example.com' },
          phone_number: { type: :string, example: '123-456-7890' }
        },
        required: %w[first_name last_name job_title country salary email phone_number]
      }

      response '201', 'Employee created' do
        let(:employee) { attributes_for(:employee) }

        run_test!
      end

      response '422', 'Invalid request' do
        let(:employee) { { first_name: '' } }

        run_test!
      end
    end
  end
end
