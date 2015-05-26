class Post < ActiveRecord::Base
  extend FriendlyId

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments

  #friendly_id :slug_candidates, use: [:slugged, :finders]
  friendly_id :title, use: :slugged
  # def to_param
  #   "#{id} #{title}".parameterize
  # end
  def should_generate_new_friendly_id?
    new_record? || slug.nil? || slug.blank? # you can add more condition here
  end

end
