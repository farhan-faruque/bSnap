class Post < ActiveRecord::Base
  attr_accessor :location

  belongs_to :user

end
