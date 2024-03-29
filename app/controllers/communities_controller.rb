class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[ show edit update destroy ]

  # GET /communities or /communities.json
  def index
    if params[:q] && params[:q][:with_tag].present?
      # 連続検索によるブラウザ負担を解消
      session[:q].clear
      tag_list = JSON.parse(params[:q][:with_tag]).map { |tag| tag["value"] }
      params[:q][:with_tag] = tag_list.join(",")
    end
    session[:q] = params[:q] if params[:q].present?
    @search = Community.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?
    @communities = @search.result.page(params[:page])
    @current_tab = "active"
  end

  # GET /communities/1 or /communities/1.json
  def show
    @post  = @community.posts.new
    @posts = @community.posts.order(created_at: :asc)
    @community_tags = @community.tag_counts_on(:community_tags)
    # @tag = Tag.new
    # ransack search posts
    @search = @community.posts.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty? 
    # @posts = @search.result.page(params[:page])
  end

  # GET /communities/new
  def new
    @community = Community.new
    @community_tags = @community.tag_counts_on(:community_tags)
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities or /communities.json
  def create
    @community = Community.new(community_params)
    @community_tags = @community.tag_counts_on(:community_tags)
    if user_signed_in? 
      @community.user_id = current_user.id
    else
      @community.user_id = 1
    end
    
    respond_to do |format|
      if @community.save
        format.html { redirect_to community_url(@community), notice: "Community was successfully created." }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1 or /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to community_url(@community), notice: "Community was successfully updated." }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1 or /communities/1.json
  def destroy
    @community.destroy

    respond_to do |format|
      format.html { redirect_to communities_url, notice: "Community was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def community_params
      params.require(:community).permit(
        :community_name, 
        :community_tag_list
      )
    end
end
