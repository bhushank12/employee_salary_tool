class EmployeeSerializer
  def self.call(employee)
    {
      id: employee.id,
      first_name: employee.first_name,
      last_name: employee.last_name,
      full_name: employee.full_name,
      email: employee.email,
      job_title: employee.job_title,
      country: employee.country,
      salary: employee.salary,
      phone_number: employee.phone_number
    }
  end
end
