class FavoriteCommunitiesController < ApplicationController
  before_action :set_communtiy
  before_action :check_auth

  def create
    current_user.favorite_communities.create(community_id: @community.id)
    flash.now.notice = "#{@community.user.user_name}さんの「#{@community.community_name}」をお気に入りに追加しました"
    render "result"
  end

  def destroy
    community_favorite = current_user.favorite_communities.find_by(community_id: @community.id)
    community_favorite.destroy!
    flash.now.notice = "#{@community.user.user_name}さんの「#{@community.community_name}」をお気に入りから削除しました"
    render "result"
  end

  private

  def set_communtiy
    @community = Community.find(params[:community_id])
  end

  def check_auth
    unless current_user
      flash.now.notice = "ログイン後にお気に入り登録ができます"
      render "result"
      return
    end
  end
end
