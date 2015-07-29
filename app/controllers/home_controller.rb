class HomeController < ApplicationController

  def index

    if params[:q].nil?
      @posts = Post.all
    else
      @posts = Post.search params[:q]
    end

    logger.debug @posts.as_json

  end

  def search

  end

end
