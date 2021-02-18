class SessionsController < ApplicationController
  def welcome
  end

  def new
  end

  def create
    @user = User.find_by(username: user_params[:username])
    if @user
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end