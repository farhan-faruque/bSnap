class HomeController < ApplicationController

  def index
    @posts = Post.all
    logger.debug @posts.size
  end
end
