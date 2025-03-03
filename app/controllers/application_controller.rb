class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :redirect_to_onboarding_if_needed

  private

  def redirect_to_onboarding_if_needed
    return unless user_signed_in? && !current_user.timezone_set
    return if request.path == onboarding_path # Avoid redirect loop

    redirect_to onboarding_path
  end
end
