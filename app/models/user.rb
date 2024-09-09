class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(u)
    create_with(uid: u[:uid], provider: 'google', password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end

  has_many :accomplishments, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :expectations, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
