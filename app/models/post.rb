class Post < ActiveRecord::Base
  extend FriendlyId

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :location
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments
  has_many :favourite_posts
  has_many :favorited_by, through: :favourite_posts, source: :user


  #friendly_id :slug_candidates, use: :slugged
  friendly_id :title, use: :slugged
  # def to_param
  #   "#{id} #{title}".parameterize
  # end
  def should_generate_new_friendly_id?
    new_record? || slug.nil? || slug.blank? # you can add more condition here
  end

  def slug_candidates
    [
        :title,
        [:title, :id]
    ]
  end

  def favourites?(user)
    self.favorited_by.exists?(user.id)
  end

  def toggle_favorites!(user)
    favourites?(user) ? favorited_by.delete(user) : favorited_by.push(user)
  end

  def self.search(query)
    __elasticsearch__.search(
        {
          query: {
              multi_match: {
                  query: query,
                  fields: ['title^10', 'description']
              }
          }
        }
    )
  end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :description, analyzer: 'english'
    end
  end

end
# Delete the previous articles index in Elasticsearch
Post.__elasticsearch__.client.indices.delete index: Post.index_name rescue nil

# Create the new index with the new mapping
Post.__elasticsearch__.client.indices.create \
  index: Post.index_name,
  body: { settings: Post.settings.to_hash, mappings: Post.mappings.to_hash }

# Index all article records from the DB to Elasticsearch
Post.import