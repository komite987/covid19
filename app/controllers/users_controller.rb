class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :require_admin

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User added successfully"
      redirect_to users_path
    else
      render 'new'
    end
  end



  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user.admin && (@user != current_user)
      flash[:error] = "Can't edit admin"
      redirect_to users_path
    end

  end

  def update

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      flash[:success] = "Update completed"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    if @user.admin
      flash[:error] = "Can't delete admin"
      redirect_to users_path
    else
      @user.destroy
      flash[:success] = "User has been deleted"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :address,
                                 :phone,
                                 :mobile,
                                 :photo,
                                 :password,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end


  def require_admin
    if !current_user.admin
      flash.now[:error] = "Only admin can do that"
      redirect_to root_path
    end
  end


  end
