class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?  

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
        password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :nickname,
                    :last_name,
                    :first_name,
                    :last_name_kana,
                    :first_name_kana,
                    :birthday,
                    :image,
                    :profile
                  ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

end