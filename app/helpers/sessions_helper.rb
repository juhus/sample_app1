module SessionsHelper
	
	def sign_in(user)
	    cookies.permanent[:remember_token] = user.remember_token
	    current_user = user 	#purpose of this line is to create current_user, accessible in both controllers and views, which will allow constructions such as <%= current_user.name %> and redirect_to current_user
    end

    def signed_in?
    	!current_user.nil?
  	end
    
    def current_user=(user)		#defines a method current_user= expressly designed to handle assignment to current_user.
    	@current_user = user
  	end

  	def current_user
    	@current_user ||= user_from_remember_token #calls the user_from_remember_token method the first time current_user is called, but on subsequent invocations returns @current_user without calling user_from_remember_token.
  	end  #||= assigning to a variable if it’s nil but otherwise leaving it alone

  	def sign_out
	    current_user = nil
	    cookies.delete(:remember_token)
  	end

  	private

	    def user_from_remember_token
	      remember_token = cookies[:remember_token]
	      User.find_by_remember_token(remember_token) unless remember_token.nil?
	    end

end
