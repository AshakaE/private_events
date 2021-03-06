class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'You successfuly signed in, You can log in now !'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @events = @user.invitations.joins(event: :user).select(:event_name, :location, :time, :username).order(time: :asc)
    @future_events = @events.where('time >= :now', now: DateTime.now)
    @past_events = @events.where('time < :now', now: DateTime.now)
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
