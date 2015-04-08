class Authentication < ActiveRecord::Base
  belongs_to :user
  validates :provider,:uid, :presence => true
  validates :uid,:uniqueness => {:scope => :provider }

  class << self
    def find_by_auth(auth)

    end

    def facebook

    end

    def google

    end

  end

end
