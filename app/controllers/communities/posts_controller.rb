class Communities::PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_community, only: %i[ new create update ]

  # GET /communities/posts or /communities/posts.json
  def index
    @posts = Post.all
  end

  # GET /communities/posts/1 or /communities/posts/1.json
  def show
  end

  # GET /communities/posts/new
  def new
    @post = Post.new
  end

  # GET /communities/posts/1/edit
  def edit
  end

  # POST /communities/posts or /communities/posts.json
  def create
    @post = @community.posts.new(post_params)
    @posts = @community.posts
    if user_signed_in? 
      @post.user_id = current_user.id
    else
      @post.user_id = 1
    end
    if @post.save
      flash.now.notice = 'post was successfly created'
    end
  end

  # PATCH/PUT /communities/posts/1 or /communities/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/posts/1 or /communities/posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to@posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_community
      @community = Community.find_by(id: params[:community_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(
        :content,
        :community_id,
      )
    end
end
