# app/controllers/relationships_controller.rb
class RelationshipsController < ApplicationController
  # before_action :authenticate_user! # Devise のヘルパー
  before_action :check_auth

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    flash.now.notice = "#{@user.user_name}さんをフォローしました"
    render "users/result"
  end

  def destroy
    relationship = current_user.active_relationships.find_by(followed_id: params[:id])
    @user = relationship.followed
    current_user.unfollow(@user)
    flash.now.notice = "#{@user.user_name}さんをフォローを解除しました"
    render "users/result"
  end

  private
  def check_auth
    unless user_signed_in?
      @user = User.find(params[:followed_id])
      flash.now.notice = "ログイン後にフォローできます"
      render "users/result"
      return
    end
  end
end
