class EmployeesController < ApplicationController
    before_action :signed_in_user
    before_action :admin_user, only: :destroy
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
    
    def destroy
        Employee.find(params[:id]).destroy
        flash[:success] = "Employee deleted."
        redirect_to employees_url
    end


    private
        def employee_params
            params.require(:employee).permit(:name, :email, :password, :password_confirmation)
        end

        def admin_user
            redirect_to root_url unless current_user.admin?
        end

end
