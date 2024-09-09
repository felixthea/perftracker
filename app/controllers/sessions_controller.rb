class SessionsController < ApplicationController
  def google_auth
    # Get access tokens from the google server
    access_token = request.env['omniauth.auth']
    user = User.from_omniauth(access_token)
    log_in user  # Defined in sessions_helper
    redirect_to root_path, notice: 'Successfully logged in with Google!'
  end

  def destroy
    log_out  # Defined in sessions_helper
    redirect_to root_path, notice: 'Logged out!'
  end
end
