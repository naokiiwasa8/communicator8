class SettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
  end

  def profile
    @current_tab = "profile"
  end

  def sns_links
    @current_tab = "sns_links"
  end

  def email
    @current_tab = "email"
  end

  def password
    @current_tab = "password"
  end

  def update
    if @user.update(setting_user_params)
      redirect_to user_path(@user), notice: 'Profile updated!'
    else
      url = Rails.application.routes.recognize_path(request.referrer)
      previous_action = url[:action]
      case previous_action
      when "profile"
        render :profile
      when "sns_links"
        render :sns_links
      when "email"
        render :email
      when "password"
        render :password
      else
        render :profile
      end
    end
  end

  private

  def set_current_user
    @user = current_user
  end 

  def setting_user_params
    params.require(:user).permit(
      :email, 
      :user_name, 
      :avatar,
      profile_attributes: [
        :id,
        :job_title, 
        :years_of_experience,
        :company,
        :birthday,
        :biography
      ]
    )
  end

end
