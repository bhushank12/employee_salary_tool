class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors.full_messages }, status: :unprocessable_content
    end
  end

  def index
    @employees = Employee.all
    render json: @employees
  end

  def show
    render json: @employee, status: :ok
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: :ok
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
