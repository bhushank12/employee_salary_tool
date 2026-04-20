class EmployeesController < ApplicationController
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created
    else
      render json: { errors: @employee.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @employees = Employee.all
    render json: @employees
  end

  def show
    @employee = Employee.find(params[:id])
    render json: @employee
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Employee not found' }, status: :not_found
  end

  private
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :job_title, :country, :salary, :email, :phone_number)
  end
end
