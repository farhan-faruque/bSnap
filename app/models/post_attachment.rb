class PostAttachment < ActiveRecord::Base
  mount_uploader :avatar,ImageUploader
  belongs_to :post
end
