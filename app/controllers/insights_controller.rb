class InsightsController < ApplicationController
  def index
    country = params[:country]
    job_title = params[:job_title]
    return render_bad_request if country.blank?

    employees = Employee.where(country: country)

    render json: {
      overall: overall_stats(employees),
      job_title_average_salary: job_title_average_salary(employees, job_title),
      total_employees: employees.size,
      median_salary: median_salary(employees),
    }
  end

  private

  def overall_stats(employees)
    {
      min_salary: employees.minimum(:salary)&.to_f,
      max_salary: employees.maximum(:salary)&.to_f,
      average_salary: employees.average(:salary)&.to_f&.round(2)
    }
  end

  def job_title_average_salary(employees, job_title)
    return {} unless job_title.present?

    {
      job_title: job_title,
      average_salary: employees.where(job_title: job_title).average(:salary)&.to_f&.round(2)
    }
  end

  def median_salary(employees)
    employees.pick(Arel.sql('PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY salary)'))
  end


  def render_bad_request
    render json: { error: 'Country parameter is required' }, status: :bad_request
  end
end
