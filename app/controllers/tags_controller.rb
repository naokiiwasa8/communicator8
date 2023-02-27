class TagsController < ApplicationController
  before_action :set_community, only: %i[ edit update destroy ]
  
  def new
    @tag = @community.tags.new
  end

  def edit
  end
  
  def create
    @tag = @community.tags.new(tag_params)
    if @tag.save?
      flash[:notice] = 'tag was created'
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

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end

end
