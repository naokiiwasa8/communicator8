# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
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

  def set_current_user
    @user = current_user
  end 

  def user_params
    params.require(:user).permit(
      :email, 
      :user_name, 
      :avatar
    )
  end
end
