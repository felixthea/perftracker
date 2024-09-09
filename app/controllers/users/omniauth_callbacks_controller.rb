class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
   def google_oauth2
     user = User.from_google(from_google_params)
     puts "in here"
     if user.present?
       puts "first"
       puts user
       sign_out_all_scopes
       flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
       sign_in_and_redirect user, event: :authentication
     else
       puts "second"
       flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
       redirect_to new_user_session_path
     end
    end

    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
end