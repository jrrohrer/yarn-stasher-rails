class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    @project = Project.popular_project.first
    @new_projects = Project.recent_projects
    @top_commenter = User.top_commenter.first
    @popular_yarn = Yarn.popular_yarn.first
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
    # set the user, then use the has_many relationship to show that user's yarns and projects in the view. That way it doesn't matter what user is logged in, the username, yarns, and projects in the view will always match the ID in the URL. 
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :image)
  end
end
