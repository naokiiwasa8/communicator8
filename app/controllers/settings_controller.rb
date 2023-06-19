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
  end

  def update_profile
    setting_params = setting_user_params
  
    if setting_params[:skill_tag_list].blank?
      setting_params.delete(:skill_tag_list)
    end
    
    if setting_params[:profile_attributes][:job_title_tag_list].blank?
      setting_params[:profile_attributes].delete(:job_title_tag_list)
    end
    
    if @user.update(setting_params)
      flash.notice = 'プロフィールを更新しました'
      redirect_to user_path(@user)
    else
      @current_tab = "profile"
      render :profile
    end
  end
  
  def update_sns_links
    if @user.update(setting_user_params)
      flash.notice = 'SNSリンクを更新しました'
      redirect_to user_path(@user)
    else
      render :sns_links
    end
  end
  
  def update_email
    if @user.update(setting_user_params)
      flash.notice = 'メールアドレスを変更しました'
      redirect_to user_path(@user)
    else
      render :email
    end
  end

  def update_password
    if password_params[:password].present? && @user.update_with_password(password_params)
      bypass_sign_in(@user)
      @successful_update = true
      redirect_to user_path(@user), notice: 'パスワードを更新しました.'
      return
    else
      @current_tab = "password"
      render action: :password
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
      :skill_tag_list,
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
        :job_title_tag_list,
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
