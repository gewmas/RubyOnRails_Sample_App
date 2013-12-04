module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		# @... instance variable
		@current_user = user 
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

# The store_location method puts the requested URL in the session variable under the key :return_to, 
# but only for a GET request (if request.get?). 
# This prevents storing the forwarding URL if a user, say, submits a form when not logged in 
# (which is an edge case but could happen if, e.g., a user deleted the remember token by hand before submitting the form); 
# in this case, the resulting redirect would issue a GET request to a URL expecting POST, PATCH, or DELETE, thereby causing an error.
	def store_location
		session[:return_to] = request.url if request.get?
	end
end