class SessionsController < ApplicationController

    def new
    end

    def create
        @user = Employee.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            sign_in @user
            flash[:success] = "Signed In Successfully"
            redirect_to timestamps_path 
        else
            flash.now[:error] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        sign_out
        redirect_to root_url
    end
end
