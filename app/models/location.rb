class Location < ActiveRecord::Base
  has_many :posts
  has_many :users

  def to_s
    name
  end

end
