class Post < ActiveRecord::Base
  #extend FriendlyId

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments

  #friendly_id :slug_candidates, use: [:slugged, :finders]

  def to_param
    "#{id} #{title}".parameterize
  end

end
