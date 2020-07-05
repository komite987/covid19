class AdminController < ApplicationController
  before_action :require_admin

  def board
    @users = User.all
  end



  private

  def require_admin
    if signed_in? && !current_user.admin
      flash[:notice] = "You are not an admin"
      redirect_to root_path
    end
  end




end
