class Access::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_sign_up_params, only: [:create, :validate]

# before_filter :configure_account_update_params, only: [:update]

  before_action :check_adm, only: [:users, :roles_update]
#  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def profile
    @user = User.find(params[:id])
  end
 
  def users
    @users = User.all.order(:id)
    @roles = Role.all.order(:id)
  end

  def roles_update
    user = User.find(params[:id])
    if params[:act] == 'true'
      user.add_role(params[:role])
    else
      user.remove_role params[:role]
    end
    redirect_to users_all_path
  end

  def validate

    user = User.new(params.require(:user).permit(:email, :password, :username, :password_confirmation, :captcha))
    user.valid?
    field = params[:user].first[0]
    @errors = user.errors[field]

    if @errors.empty?
      @errors = true
    else
      name = t("activerecord.attributes.user.#{field}")
      @errors.map! { |e| "#{name} #{e}<br/>" }
    end

    respond_to do |format|
      format.json { render json: @errors }
    end

  end
  

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if simple_captcha_valid?
      super                   
    else                         
      build_resource         
      flash[:danger] =  t('simple_captcha.not_valid')
      render :new                                 
    end 
   end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :attribute
  end
  
  def check_adm
    check_admin
  end

end
