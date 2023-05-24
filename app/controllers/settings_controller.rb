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

  def update_password
    if @user.update_with_password(password_params)
      bypass_sign_in(@user)
      @successful_update = true
      redirect_to user_path(@user), notice: 'パスワードを更新しました.'
      return
    else
      render :password
    end
  end

  def update
    url = Rails.application.routes.recognize_path(request.referrer)
    previous_action = url[:action]
    if @user.update(setting_user_params)
      case previous_action
      when "profile"
        flash.notice = 'プロフィールを更新しました'
      when "sns_links"
        flash.notice = 'SNSリンクを更新しました'
      when "email"
        flash.notice = 'メールアドレスを変更しました'
      end
      redirect_to user_path(@user)
      return
    else
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
        :biography,
        :github_url,
        :teratail_url,
        :qiita_url,
        :twitter_url,
        :note_url,
        :connpass_url,
        :zenn_url,
        :doorkeeper_url,
      ]
    )
  end

  def password_params
    params.require(:user).permit(
      :current_password, 
      :password, 
      :password_confirmation
    )
  end

end
