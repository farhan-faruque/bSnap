module PostsHelper
  def user_name(post)
    return String.new if post.nil? or post.user.nil?
    return post.user.user_name
  end

  def post_image(post)
    if post.post_attachments.first.nil?
      return image_tag("img_no_image_avail.png",:width => 150, :height => 200, :crop => :fill)
    else
      cl_image_tag( post.post_attachments.first.avatar, :width => 150, :height => 200, :crop => :fill)
    end
  end
end
