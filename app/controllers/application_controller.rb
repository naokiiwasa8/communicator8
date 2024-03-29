class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Exception, with: :server_error
  before_action :store_user_location!, if: :storable_location?

  protected
  # User登録のカスタマイズ（user_nameを登録できるように追加）
  def configure_permitted_parameters
    added_attrs = [ :email, :user_name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  def server_error(e)
    ExceptionNotifier.notify_exception(e, :env => request.env, :data => {:message => "error"})
    # respond_to do |format|
    #   # エラー画面へレンダー
    #   format.html { render template: 'front/errors/500', layout: 'front/layouts/error', status: 500 }
    #   format.all { render nothing: true, status: 500 }
    # end
  end

  # ログイン直後にログインページの前のページへ遷移
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
