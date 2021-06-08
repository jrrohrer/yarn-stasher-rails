class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:welcome, :new, :create, :omniauth]

  def welcome
  end

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:message] = "Login successful! Welcome, #{user.username}!"
      redirect_to home_path
    else
      flash[:error] = "Incorrect login information. Please try again."
      redirect_to '/login'
    end
  end

  def omniauth
    @user = User.create_by_oauth(auth)
    session[:user_id] = @user.id
    flash[:message] = "Login successful! Welcome, #{@user.username}!"
    redirect_to home_path
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