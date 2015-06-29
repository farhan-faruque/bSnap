class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy,:favourite]
  before_action  :authenticate_user!, only: [:new,:edit, :update, :destroy,:favourite]

  # GET /searches
  # GET /searches.json
  def index
    @posts = Post.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @post_attachments = @post.post_attachments.all
  end

  # GET /searches/new
  def new
    @post = Post.new
    3.times do
      @post.post_attachments.build
    end
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        params[:post_attachments]['avatar'].each do |a|
          @post_attachment = @post.post_attachments.create(:avatar => a, :post_id => @post.id)
        end
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @post.update(search_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PUT favorite post
  def favourite
    # type = params[:type]
    # if type.to_sym.eql? :favourite
    #   current_user.favorites << @post
    #   redirect_to :back, notice: 'You favorited #{@post.title}'
    #
    # elsif type.to_sym.eql?  :unfavourite
    #   current_user.favorites.delete(@post)
    #   redirect_to :back, notice: 'Unfavorited #{@post.title}'
    #
    # else
    #   # Type missing, nothing happens
    #   redirect_to :back, notice: 'Nothing happened.'
    # end

    if current_user.present?
      @post.toggle_favorites!(current_user)
      respond_to do |format|
        #format.html { redirect_to searches_url, notice: 'Post was successfully destroyed.' }
        #format.json { render :favourite => current_user.favorites.include?(@post) }
        format.json { render json: {added: current_user.favorites.include?(@post)}}
      end
    else
      render nothing: true, :status => :unauthorized
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :location_id,:image, :description,:category_ids => [],
                                 post_attachments_attributes: [:id, :post_id, :avatar])
  end
end

