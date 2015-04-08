class Post < ActiveRecord::Base

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url =>  ActionController::Base.helpers.asset_path('cam.png')

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
