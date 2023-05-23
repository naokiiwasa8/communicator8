class HomeController < ApplicationController
  before_action :set_communities_page
  before_action :set_ransack_search
  
  def index
    @current_tab = "active"
  end

  def active
    @current_tab = "active"
    render "active_tab"
  end

  def favorites
    unless user_signed_in?
      flash.now.notice = "ログイン後にお気に入り機能が利用できます"
      render "active_tab"
      return
    end
    @communities = current_user.favorited_communities.order(created_at: :desc).page(params[:page])
    @current_tab = "favorites"
    render "active_tab"
  end

  def followings
    unless user_signed_in?
      flash.now.notice = "ログイン後にフォロー機能が利用できます"
      render "active_tab"
      return
    end
    following_ids = current_user.followings.pluck(:id)
    @communities = Community.where(user_id: following_ids).page(params[:page])
    @current_tab = "followings"
    render "active_tab"
  end

  private

  def set_communities_page
    @communities = Community.all.order(created_at: :desc)
    @communities = Community.page(params[:page])
  end

  def set_ransack_search
    # ransack search
    @search = Community.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty? 
    @communities = @search.result.page(params[:page])
  end
end


