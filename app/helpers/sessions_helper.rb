module SessionsHelper

    def sign_in(user)
        remember_token = Employee.new_remember_token
        cookies[:remember_token] = { value: remember_token,
                                               expires: 7.days.from_now.utc }
        user.update_attribute(:remember_token, Employee.encrypt(remember_token))
        self.current_user = user
    end

    def signed_in?
        !current_user.nil?
    end

    def current_user=(user)
        @current_user = user
    end

    def current_user?(user)
        @current_user == user
    end

    def current_user
        remember_token = Employee.encrypt(cookies[:remember_token])
        @current_user ||= Employee.find_by(remember_token: remember_token)
    end

    def sign_out
        self.current_user = nil
        cookies.delete(:remember_token)
    end

    def signed_in_user
        redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end 
end
