class Post < ActiveRecord::Base

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories

  mount_uploader :image,ImageUploader

end
