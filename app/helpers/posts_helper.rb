module PostsHelper
  def user_name
    return String.new if @post.nil? or @post.user.nil?
    return @post.user.user_name
  end

  def post_image
    if @post.post_attachments.first.nil?
      return image_tag("img_no_image_avail.png",:width => 150, :height => 200, :crop => :fill)
    else
      cl_image_tag( @post.post_attachments.first.avatar, :width => 150, :height => 200, :crop => :fill)
    end
  end

  def get_carousal_class(pos)
    return  pos == 0 ? "active item" : "item"
  end

  def star_type
    return :unfavourite if @post.favourites?(current_user)
    :favourite
  end

  def star_class
    return "glyphicon glyphicon-star" if @post.favourites?(current_user)
    "glyphicon glyphicon-star-empty"
  end


end
