class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :location

  def to_param
    #self.user.name.parameterize.to_s
    logger.debug 'name'
  end

end
