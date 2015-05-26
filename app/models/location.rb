class Location < ActiveRecord::Base
  has_many :posts
  #has_many :users
  has_many :profiles

  def to_s
    name
  end

end
