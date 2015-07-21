class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

#  def render_403
#    render status: :forbidden, text: 'Forbidden'
#  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, flash: { danger: "<strong>Access denied</strong>: #{exception.message}" }#, status: 403
  end

  def check_admin
    if !current_user or !current_user.has_role?(:admin)
      raise CanCan::AccessDenied.new("Sorry... But you are not admin!")
    else
      true
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:last_name, :first_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:last_name, :first_name, :email, :password, :password_confirmation, :current_password) }
  end

end
