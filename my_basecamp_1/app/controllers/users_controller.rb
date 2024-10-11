class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:set_admin, :remove_admin, :index]

  def index
    @users = User.all if current_user&.admin?
  end

  def set_admin
    @user = User.find(params[:id])
    @user.set_admin

    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to users_path, notice: 'User is now an admin.' }
    end
  end

  def remove_admin
    @user = User.find(params[:id])
    @user.remove_admin

    respond_to do |format|
      format.turbo_stream 
      format.html { redirect_to users_path, notice: 'Admin rights removed.' }
    end
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end
end
