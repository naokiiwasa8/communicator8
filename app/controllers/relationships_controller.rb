# app/controllers/relationships_controller.rb
class RelationshipsController < ApplicationController
  # before_action :authenticate_user! # Devise のヘルパー
  before_action :check_auth
  before_action :set_user

  def create
    @relationship_user = User.find(params[:followed_id])
    current_user.follow(@relationship_user)
    flash.now.notice = "#{@relationship_user.user_name}さんをフォローしました"
    render "users/result"
  end

  def destroy
    relationship = current_user.active_relationships.find_by(followed_id: params[:followed_id])
    @relationship_user = relationship.followed
    current_user.unfollow(@relationship_user)
    flash.now.notice = "#{@relationship_user.user_name}さんのフォローを解除しました"
    render "users/result"
  end

  private
  def check_auth
    unless user_signed_in?
      @relationship_user = User.find(params[:followed_id])
      @user = User.find(params[:user_id])
      flash.now.notice = "ログイン後にフォローできます"
      render "users/result"
      return
    end
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
