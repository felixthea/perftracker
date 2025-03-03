class UsersController < ApplicationController
  def custom_logout
    sign_out(current_user)  # Logs out the current user
    redirect_to root_path, notice: "You have been logged out."
  end

  before_action :authenticate_user!

  def onboarding
    @user = current_user
  end

  def update_timezone
    @user = current_user
    if @user.update(timezone_params.merge(timezone_set: true))
      redirect_to root_path, notice: "Your timezone has been set!"
    else
      flash.now[:alert] = "Please select a valid timezone."
      render :onboarding
    end
  end

  private

  def timezone_params
    params.require(:user).permit(:timezone)
  end
end
