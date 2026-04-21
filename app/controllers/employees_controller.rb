class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: EmployeeSerializer.call(employee), status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_content
    end
  end

  def index
    employees = Employee
                  .select(:id, :first_name, :last_name, :email, :job_title, :country, :salary, :phone_number)
                  .page(params[:page] || 1)
                  .per(params[:per_page] || 10)

    render json: {
      data: employees.map { |e| EmployeeSerializer.call(e) },
      meta: {
        current_page: employees.current_page,
        total_pages: employees.total_pages,
        total_count: employees.total_count
      }
    }, status: :ok
  end

  def show
    render json: EmployeeSerializer.call(@employee), status: :ok
  end

  def update
    if @employee.update(employee_params)
      render json: EmployeeSerializer.call(@employee), status: :ok
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :job_title, :country, :salary, :email, :phone_number)
  end

  def record_not_found
    render json: { error: 'Employee not found' }, status: :not_found
  end
end
