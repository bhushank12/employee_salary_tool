class EmployeeSerializer
  def self.call(employee)
    {
      id: employee.id,
      full_name: employee.full_name,
      email: employee.email,
      job_title: employee.job_title,
      country: employee.country,
      salary: employee.salary,
      phone_number: employee.phone_number
    }
  end
end
