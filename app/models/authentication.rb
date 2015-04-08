class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :provider,:uid, :presence => true
  validates :uid,:uniqueness => {:scope => :provider }

  class << self
    def find_by_oauth(auth)
      where(:provider => auth.provider, :uid => auth.uid).first
    end

    def facebook
      where(:provider => 'google').first
    end

    def google
      where(:provider => 'google').first
    end

  end

end
