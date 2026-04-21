require 'swagger_helper'

RSpec.describe 'Insights API', type: :request do
  path '/insights' do
    get 'Get insights for country and job title' do
      tags 'Insights'
      produces 'application/json'
      parameter name: :country, in: :query, type: :string, required: true, description: 'Required filter to get min, max, average, median salary and employee count for a specific country'
      parameter name: :job_title, in: :query, type: :string, required: false, description: 'Optional filter to get average salary for a specific job title'

      response '200', 'Insights retrieved' do
        schema type: :object,
          properties: {
            overall: {
              type: :object,
              properties: {
                min_salary: { type: :number, format: :float },
                max_salary: { type: :number, format: :float },
                average_salary: { type: :number, format: :float }
              }
            },
            job_title_average_salary: {
              type: :object,
              properties: {
                job_title: { type: :string },
                average_salary: { type: :number, format: :float }
              },
            },
            total_employees: { type: :integer },
            median_salary: { type: :number, format: :float }
          }

        example 'application/json', :example, {
          overall: {
            min_salary: 30000.0,
            max_salary: 250000.0,
            average_salary: 135000.0
          },
          job_title_average_salary: {
            job_title: "Engineer",
            average_salary: 82500.0
          },
          total_employees: 7,
          median_salary: 150000.0
        }

        let(:country) { 'India' }
        let(:job_title) { 'Engineer' }

        before do
          create(:employee, salary: 50000, job_title: "Engineer", country: "India")
          create(:employee, salary: 100000, job_title: "Engineer", country: "India")
          create(:employee, salary: 150000, job_title: "Engineer", country: "India")
          create(:employee, salary: 30000, job_title: "Engineer", country: "India")
          create(:employee, salary: 200000, job_title: "Manager",  country: "India")
          create(:employee, salary: 250000, job_title: "Manager",  country: "India")
          create(:employee, salary: 230000, job_title: "Manager",  country: "India")
        end

        run_test! do |response|
          data = JSON.parse(response.body)

          expect(response).to have_http_status(:ok)
          expect(data["overall"]["min_salary"]).to eq(30000.0)
          expect(data["overall"]["max_salary"]).to eq(250000.0)
          expect(data["overall"]["average_salary"]).to eq(144285.71)
          expect(data["job_title_average_salary"]["job_title"]).to eq("Engineer")
          expect(data["job_title_average_salary"]["average_salary"]).to eq(82500.0)
          expect(data["total_employees"]).to eq(7)
          expect(data["median_salary"]).to eq(150000.0)
        end
      end

      response '400', 'Invalid request' do
        let(:country) { nil }

        run_test! do |response|
          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)['error']).to eq('Country parameter is required')
        end
      end
    end
  end
end
