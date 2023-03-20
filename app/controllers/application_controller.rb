class ApplicationController < ActionController::Base


    def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
    def logged_in?
		!!current_user
	end
    def require_user
		if !logged_in?
            flash[:alert] = "You must be logged in to perform that action"
            redirect_to login_path
		end
	end

	def require_administrative
  		allowed_roles = ['principal', 'superadmin']
		unless allowed_roles.include?(current_user.role.name)
			flash[:alert] = "You must be logged in as a Principal, or Superadmin to perform that action"
			redirect_back(fallback_location: root_path)
		end
  	end
	def require_teacher
  		allowed_roles = ['teacher', 'principal', 'superadmin']
		unless allowed_roles.include?(current_user.role.name)
			flash[:alert] = "You must be logged in as a Teacher, Principal, or Superadmin to perform that action"
			redirect_back(fallback_location: root_path)
		end
  	end
end
