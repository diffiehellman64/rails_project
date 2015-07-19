class Admin::RolesController < ApplicationController

  before_action do check_admin end

  def index
    @users = User.all
    @roles = Role.all
  end

  def update
    user = User.find(params[:id])
    case params[:act]
      when 'del'
        user.remove_role params[:role]
      when 'add'
        user.add_role(params[:role])
    end
    redirect_to admin_roles_path
  end

end
