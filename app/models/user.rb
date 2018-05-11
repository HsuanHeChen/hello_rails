class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
         :omniauthable, omniauth_providers: %i[facebook]

  before_create :generate_authentication_token

  def self.from_omniauth(auth)
    # Find existing user by facebook uid
    existing_user = User.find_by_uid(auth.uid)
    if existing_user
      existing_user.fb_token = auth.credentials.token
      existing_user.save!
      return existing_user 
    end
       
    # Find existing user by email
    existing_user = User.find_by_email(auth.info.email)
    if existing_user
      existing_user.uid = auth.uid
      existing_user.provider = auth.provider
      existing_user.fb_token = auth.credentials.token
      existing_user.save!
      return existing_user
    end

    # Create new user
    user = User.new
    user.provider = auth.provider
    user.fb_token = auth.credentials.token
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.skip_confirmation!
    user.save!
    return user
  end

  def delete_access_token(auth)
    @graph ||= Koala::Facebook::API.new(auth.credentials.token)
    @graph.delete_connections(auth.uid, "permissions")
  end

  def generate_authentication_token
     self.authentication_token = Devise.friendly_token
  end

  # for api
  def self.get_fb_data(access_token)
    res = RestClient.get "https://graph.facebook.com/v2.5/me", {params: {access_token: access_token}}

    if res.code == 200
      JSON.parse(res.to_str)
    else
      Rails.logger.warn(res.body)
      nil
    end
  end

end
