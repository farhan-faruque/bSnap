module PostsHelper
  def user_name(post)
    return String.new if post.nil? or post.user.nil?
    post.user.user_name
  end

  def post_image(post)
      return image_tag("img_no_image_avail.png",:width => 150, :height => 200, :crop => :fill) #if  post.post_attachments.nil? || post.post_attachments.first.nil?
      cl_image_tag( post.post_attachments.first.avatar, :width => 150, :height => 200, :crop => :fill)
  end

  def get_carousal_class(pos)
    return  pos == 0 ? "active item" : "item"
  end

  def star_type(post)
    return :unfavourite if post.favourites?(current_user)
    :favourite
  end

  def star_class(post)
    return "glyphicon glyphicon-star" if post.favourites?(current_user)
    "glyphicon glyphicon-star-empty"
  end


end
