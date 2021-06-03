class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:home, :new, :create]

  def home
  end

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "Incorrect login information. Please try again."
      redirect_to '/login'
    end
  end

  def omniauth
    @user = User.create_by_oauth(auth)
    session[:user_id] = @user.id
    redirect_to user_path(@user) 
  end

  def destroy
    session.clear
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end