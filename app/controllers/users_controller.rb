class UsersController < ApplicationController

  before_action :set_user, except: [:index, :new, :create]
  before_action :require_admin
  before_action :set_attr, only: [:update]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    contract = NewUserContract.new
    validation = contract.call(request.params[:user])
    if validation.success?
      @user = User.new(user_params)
      @user.save
      flash[:success] = "User added successfully"
      redirect_to users_path
    else
      @errors = validation.errors.to_h
      render 'new', status: 400
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
    set_attr
    # render json:
    contract = EditUserContract.new
    validation = contract.call(request.params[:user])
    if validation.success?
      if params[:user][:email] == @user.email
        params[:user].delete(:email)
      else
        if User.find_by_email(request.params[:user][:email])
          e = Errors::BadRequest.new("Email has been taken")
          Rails.logger.error e.detail
          ErrorSerializer.new(e)
          flash.now[:error] = "#{e.detail}"
          render 'edit' , status: e.status and return 
        end
      end

      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      elsif params[:user][:password_confirmation] != params[:user][:password]
        e = Errors::BadRequest.new("Password confirmation does not match password")
        Rails.logger.error e.detail
        ErrorSerializer.new(e)
        flash.now[:error] = "#{e.detail}"
        render 'edit' , status: e.status and return 
      end
      @user.update(user_params)                       
      flash[:success] = "Update completed"
      redirect_to users_path
    else
      @errors = validation.errors.to_h
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
      redirect_to users_url
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :address, :phone, :mobile, :photo, :remove_photo, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end


  def require_admin
    if !current_user.admin
      flash[:error] = "Only admins can do this"
      redirect_to root_path 
    end
  end

  def set_attr
    if request.params[:user][:name].blank?
      request.params[:user][:name] = @user.name
    end
    if request.params[:user][:email].blank?
      request.params[:user][:email] = @user.email
    end
    if request.params[:user][:phone].blank?
      request.params[:user][:phone] = @user.phone
    end
    if request.params[:user][:mobile].blank?
      request.params[:user][:mobile] = @user.mobile
    end
    if request.params[:user][:address].blank?
      request.params[:user][:address] = @user.address
    end
  end



end
    # render json: 
