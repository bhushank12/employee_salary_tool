class InsightsController < ApplicationController
  def index
    return render_bad_request if params[:country].blank?

    employees = Employee.where(country: params[:country])
    render json: {
      overall: overall_stats(employees)
    }
  end

  private
  def overall_stats(employees)
    {
      min_salary: employees.minimum(:salary)&.to_f,
      max_salary: employees.maximum(:salary)&.to_f,
      average_salary: employees.average(:salary)&.to_f.round(2)
    }
  end

  def render_bad_request
    render json: { error: 'Country parameter is required' }, status: :bad_request
  end
end
