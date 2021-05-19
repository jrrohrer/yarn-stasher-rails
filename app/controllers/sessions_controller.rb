class SessionsController < ApplicationController
  def home
  end

  def new
    
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      # add flash message here
      redirect_to '/login'
    end
  end
end