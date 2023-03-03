class TagsController < ApplicationController
  before_action :set_community, only: %i[ new create edit update destroy ]
  
  def new
    @tag = @community.tags.new
    @community_tag = @community.community_tags.new
  end

  def edit
  end
  
  def create
    @tag = Tag.new(tag_params)
    @community_tag = @community.community_tags.build(tag: @tag)
    if @tag.save && @community_tag.save
      flash[:notice] = 'tag was created'
      redirect_to community_url(@community)
    end
  end

  def update
    if @tag.update?
      flash[:notice] = 'tag was updated'
    end
  end

  def destroy
    if @tag.destroy?
      flash[:notice] = 'tag was destroyed'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = Tag.find(params[:id])
  end
  def set_community
    @community = Community.find(params[:community_id] || params[:tag][:community_id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end
  

end
