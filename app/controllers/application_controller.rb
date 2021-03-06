class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  include SimpleCaptcha::ControllerHelpers

  rescue_from CanCan::AccessDenied do |exception|
    if request.headers['X-PJAX'] # pjax
      render_403 exception.message
    elsif request.xhr? # ajax
      render status: :forbidden, text: 'Forbidden'
    else 
      redirect_to main_app.root_path, flash: { danger: "<strong>#{t('errors.forbidden')}:</strong> #{exception.message}" }
    end
  end

  def check_admin
    if !current_user or !current_user.has_role?(:admin)
      raise CanCan::AccessDenied.new(t('errors.not_admin'))
    else
      true
    end
  end

  protected

  def pjax_redirect_to(url, container = '[pjax-container]')
    render js: "$.pjax({url: '#{url}', container: '#{container}'});"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:last_name, :first_name, :email, 
                                                            :password, :password_confirmation, 
                                                            :remember_me, :avatar, :username) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :username, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:last_name, :first_name, :avatar, :email, 
                                                                   :username, :password, :password_confirmation, 
                                                                   :current_password, :avatar) }
  end

  private

  def render_403(message)
    #render text: '<div class="alert alert-danger">Access denied!</div>'
    render text: "<div id='forbidden-div' class='alert alert-danger'><strong>#{t('errors.forbidden')}:</strong> #{message}</div>"
  end

end
