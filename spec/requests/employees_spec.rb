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

    get 'List employees' do
      tags 'Employees'
      produces 'application/json'

      response '200', 'List employees' do
        before { create_list(:employee, 3) }

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(data.size).to eq(3)
        end
      end
    end
  end

  path '/employees/{id}' do
    get 'Show an employee' do
      tags 'Employees'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Employee found' do
        let(:employee) { create(:employee) }
        let(:id) { employee.id }

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(data['id']).to eq(employee.id)
        end
      end

      response '404', 'Employee not found' do
        let(:id) { 999 }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)['error']).to eq('Employee not found')
        end
      end
    end

    patch 'Update an employee' do
      tags 'Employees'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :employee, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string, example: 'John' },
          last_name: { type: :string, example: 'Doe' },
          job_title: { type: :string, example: 'Software Engineer' },
          country: { type: :string, example: 'USA' },
          salary: { type: :number, format: :float, example: 75000.00 },
          email: { type: :string, example: 'john@example.com' },
          phone_number: { type: :string, example: '1234567890' }
        }
      }

      response '200', 'Employee updated' do
        let(:employee_record) { create(:employee) }
        let(:id) { employee_record.id }
        let(:employee) { { first_name: 'Jane' } }

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(data['first_name']).to eq('Jane')
        end
      end

      response '404', 'Employee not found' do
        let(:id) { 999 }
        let(:employee) { { first_name: 'Jane' } }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)['error']).to eq('Employee not found')
        end
      end

      response '422', 'Invalid request' do
        let(:employee_record) { create(:employee) }
        let(:id) { employee_record.id }
        let(:employee) { { salary: -1000 } }

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['errors']).to include("Salary must be greater than 0")
        end
      end
    end

    delete 'Delete an employee' do
      tags 'Employees'
      parameter name: :id, in: :path, type: :integer

      response '204', 'Employee deleted' do
        let(:employee) { create(:employee) }
        let(:id) { employee.id }

        run_test! do |response|
          expect(response).to have_http_status(:no_content)
          expect(Employee.find_by(id: id)).to be_nil
        end
      end

      response '404', 'Employee not found' do
        let(:id) { 999 }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
          expect(JSON.parse(response.body)['error']).to eq('Employee not found')
        end
      end
    end
  end
end
