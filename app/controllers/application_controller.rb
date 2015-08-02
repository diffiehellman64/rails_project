class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

# layout :determine_layout

  def render_403
    #render status: :forbidden, text: 'Forbidden'
    render text: '<div class="alert alert-danger">Access denied!</div>'#, status: :forbidden
  end

  rescue_from CanCan::AccessDenied do |exception|
    if request.headers['X-PJAX']
      render text: '<div class="alert alert-danger"><strong>Access denied!</strong> ' + exception.message + '</div>'
    elsif request.xhr?
      render status: :forbidden, text: 'Forbidden'
    else 
      redirect_to main_app.root_path, flash: { danger: "<strong>Access denied</strong>: #{exception.message}" }
    end
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
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:last_name, 
                                                            :first_name, 
                                                            :email, 
                                                            :password, 
                                                            :password_confirmation, 
                                                            :remember_me, 
                                                            :avatar,
                                                            :username) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, 
                                                            :username, 
                                                            :password, 
                                                            :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:last_name, 
                                                                   :first_name, 
                                                                   :avatar, 
                                                                   :email, 
                                                                   :username, 
                                                                   :password, 
                                                                   :password_confirmation, 
                                                                   :current_password, 
                                                                   :avatar) }
  end


  private

# def determine_layout
#   request.headers['X-PJAX'] ? false : :application
# end

end
