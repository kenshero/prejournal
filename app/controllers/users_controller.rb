class UsersController < ApplicationController
  # before_filter :authorize except: login
  def index
    @users = User.where(admin: false)
  end

  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_admin
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def login
    
  end

  def logged
    user = User.find_by_username(params[:username])
    if user && user.password_digest == BCrypt::Engine.hash_secret(params[:password], user.password_digest)
      session[:user_id] = user.id
      redirect_to journals_path
    else
      redirect_to login_path
    end
  end

  def destroy_user_session
    session[:user_id] = nil
    redirect_to login_path
  end

  def user_params
    params.require(:user).permit(:username,:password,:password_confirmation,:admin)
  end

end
