class HomeController < ApplicationController
  before_action :set_communities_page
  before_action :set_ransack_search
  
  def index
    session[:q].clear if session[:q].present?
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
    favorited_communities = current_user.favorited_communities
    @search = favorited_communities.ransack(session[:q])
    @communities = @search.result.order(created_at: :desc).page(params[:page])
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
    followed_communities = Community.where(user_id: following_ids)
    @search = followed_communities.ransack(session[:q])
    @communities = @search.result.page(params[:page])
    @current_tab = "followings"
    render "active_tab"
  end

  private

  def set_communities_page
    @communities = Community.order(created_at: :desc).page(params[:page])
  end

  def set_ransack_search
    # ransack search
    @search = Community.ransack(session[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty? 
    @communities = @search.result.page(params[:page])
  end
end


