class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:title, :description, :location, :user)
    end
end

