class FavoriteCommunitiesController < ApplicationController
  def create
    @community = Community.find(params[:community_id])
    current_user.favorite_communities.create(community_id: @community.id)
    flash.now.notice = "お気に入りに追加しました"
  end

  def destroy
    @community = Community.find(params[:community_id])
    community_favorite = current_user.favorite_communities.find_by(community_id: @community.id)
    community_favorite.destroy!
    flash.now.notice = "お気に入りから削除しました"
  end
end
