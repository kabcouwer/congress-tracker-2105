class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # cookies[:user_id] = {value: '12', expires: 1.day}
    # cookies.permanent[:greeting] = 'Howdy!'
    user = user_params
    user[:username] = user[:username].downcase
    new_user = User.create(user)
    if new_user && new_user.save
      flash[:success] = "Welcome, #{new_user.username}!"
      redirect_to root_path
    end
  end

  def login_form
  end

  def authenticate_user
   found_user = User.find_by(username: params[:username])
    if found_user.authenticate(params[:password])
      session[:user_id] = found_user.id
      flash[:success] = "Welcome, #{found_user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
