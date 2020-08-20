module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
  before_action :configure_permitted_parameters, if: :devise_controller?
  end 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :phone, :address, :photo, :remove_photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :mobile, :phone, :address, :photo, :remove_photo])
  end
end