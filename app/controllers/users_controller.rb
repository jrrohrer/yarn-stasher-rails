class UsersController < ApplicationController
  def index
    @project = Project.popular_project
    @new_projects = Project.recent_projects
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @error = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @yarns = Yarn.all.select {|yarn| yarn.user_id == session[:user_id]} 
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
