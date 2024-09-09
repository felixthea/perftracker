class UsersController < ApplicationController
  def custom_logout
    sign_out(current_user)  # Logs out the current user
    redirect_to root_path, notice: 'You have been logged out.'
  end
end