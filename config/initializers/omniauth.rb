Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.FACEBOOK_APP_ID, Settings.FACEBOOK_SECRET
end
