Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['131128267079-ro7fsq0mav785kntumr06svptl33lfn9.apps.googleusercontent.com'], ENV['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'], {
    scope: 'userinfo.email, userinfo.profile',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50,
    access_type: 'offline'
  }
end
