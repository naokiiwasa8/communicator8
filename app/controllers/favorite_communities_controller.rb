class FavoriteCommunitiesController < ApplicationController
  def create
    @community = Community.find(params[:community_id])
    current_user.favorite_communities.create(community_id: @community.id)

    render turbo_stream: turbo_stream.update(
      @community,
      partial: 'layouts/parts/community',
      locals: { community: @community},
    )
  end

  def destroy
    @community = Community.find(params[:community_id])
    community_favorite = current_user.favorite_communities.find_by(community_id: @community.id)
    community_favorite.destroy!

    render turbo_stream: turbo_stream.update(
      @community,
      partial: 'layouts/parts/community',
      locals: { community: @community},
    )
  end
end
