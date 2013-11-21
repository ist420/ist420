class EmployeesController < ApplicationController
    def index
        @employees = Employee.all
    end
    def new
        @employee = Employee.new
    end
    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            flash.now[:success] = "New Employee Created Successfully"
            render :new
        else
            flash.now[:error] = "Could not create new Employee"
            redirect_to new_employee_path
        end
            
    end


    private
        def employee_params
            params.require(:employee).permit(:name)
        end
end
