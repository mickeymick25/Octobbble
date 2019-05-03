class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :projects
  has_many :shots, :through => :projects

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

  # Uncomment the section below if you want users to be created if they don't exist
  unless user
        password = Devise.friendly_token[0,20]
        user = User.create(
          name: data['name'],
          email: data['email'],
          image: data['image'],
          password: password,
          password_confirmation: password,
          provider: access_token.provider,
          uid: access_token.uid,
          token: access_token.credentials.token,
          expires: access_token.credentials.expires,
          expires_at: access_token.credentials.expires_at,
          refresh_token: access_token.credentials.refresh_token
        )
    end
    user
  end

end
