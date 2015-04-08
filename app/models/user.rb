class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :user_name,presence: true

  has_many :posts
  has_one :profile, dependent: :destroy
  has_many :authentications, dependent: :destroy

  def to_s
    email
  end
end
