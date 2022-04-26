class EmployeeController < ActionController::Base

	def index
		@employee = Employee.all
	end

  def opt_in
    current_employee.update(opt_in: params[:opt_in])
    redirect_to root_path
  end
end
