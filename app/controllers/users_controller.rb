# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user
  before_action :set_communities_page, only: [:show]

  def show
    @current_tab = "joins"
    @communities = @user.joins_communities.distinct.order(created_at: :desc).page(params[:page])
    @blank_message = '参加中のコミュニティは<br>まだありません'
  end

  def joins
    @current_tab = "joins"
    @communities = @user.joins_communities.distinct.order(created_at: :desc).page(params[:page])
    @blank_message = '参加中のコミュニティは<br>まだありません'
    render "active_tab"
  end

  def favorites
    @current_tab = "favorites"
    @communities = @user.favorited_communities.order(created_at: :desc).page(params[:page])
    @blank_message = 'お気に入りのコミュニティは<br>まだありません'
    render "active_tab"
  end

  def followings
    @current_tab = "followings"
    following_ids = @user.followings.pluck(:id)
    @communities = Community.where(user_id: following_ids).page(params[:page])
    @blank_message = 'フォローしたユーザーの<br>コミュニティはまだありません'
    render "active_tab"
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
      :avatar,
      profile_attributes: [
        :job_title, 
        :years_of_experience,
        :company,
        :birthday,
        :biography
      ]
    )
  end
end
