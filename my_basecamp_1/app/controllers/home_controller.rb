class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.admin?
        @users = User.all
      else
        flash[:notice] = 'You do not have permission to view users list.'
      end
    else
      flash[:alert] = 'Please sign in to continue.'
    end
  end
end
