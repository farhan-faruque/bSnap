class Post < ActiveRecord::Base

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories


  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url =>  ActionController::Base.helpers.asset_path('cam.png')


end
