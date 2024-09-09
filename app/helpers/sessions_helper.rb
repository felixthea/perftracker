module SessionsHelper
  # Logs in the given user.
  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  # # Returns true if the user is logged in, false otherwise.
  # def logged_in?
  #   puts current_user
  #   !current_user.nil?
  # end

  # def current_user
  #   puts "in current user"
  #   puts session.to_hash.inspect
  #   puts session[:user_id]
  #   if (user_id = session[:user_id])
  #     puts "first"
  #     @current_user ||= User.find_by(id: user_id)
  #   elsif (user_id = cookies.signed[:user_id])
  #     puts "second"
  #     user = User.find_by(id: user_id)
  #     if user && user.authenticated?(:remember, cookies[:remember_token])
  #       log_in user
  #       @current_user = user
  #     end
  #   end
  # end
end
