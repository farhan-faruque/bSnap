class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable,:omniauth_providers => [:facebook, :google_oauth2]

  validates :user_name,presence: true

  has_many :posts
  has_one :profile, dependent: :destroy
  belongs_to :location
  has_many :authentications, dependent: :destroy

  def make_random_password
    self.password = self.password_confirmation = Devise.friendly_token[0,10]
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['info']['email'] if email.blank?
    self.user_name  = omniauth['info']['name']  if user_name.blank?
    authentications.build :provider => omniauth['provider'], :uid => omniauth['uid']#, :data => omniauth.to_json
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def favourites

  end

end
