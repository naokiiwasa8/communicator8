# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user
  before_action :set_communities_page, only: [:show]

  def show
    @current_tab = "favorites"
    @communities = @user.favorited_communities.order(created_at: :desc).page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated!'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_communities_page
    @communities = Community.all.order(created_at: :desc)
    @communities = Community.page(params[:page])
  end

  def user_params
    params.require(:user).permit(
      :email, 
      :user_name, 
      :avatar
    )
  end
end
