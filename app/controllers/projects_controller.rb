class ProjectsController < ApplicationController
  before_action :require_permission, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = session[:user_id] # project being created should automatically belong to the user creating it
    @project.save
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
  end

  def edit
    @project = Project.find_by(id: params[:id])
  end

  def update
    project = Project.find_by(id: params[:id])
    project.update(project_params)
    redirect_to project_path(project)
  end

  def destroy
    project = Project.find_by(id: params[:id])
    project.destroy
   
    redirect_to user_path(current_user)
  end

  private

  def project_params
    params.require(:project).permit(:title, :pattern_name, :designer, :craft, :tool_size, :user_id)
  end

  def require_permission
    project = Project.find_by(id: params[:id])
    if project.user_id != current_user
      flash[:error] = 'Only the user who created a project may edit or delete it.'
      redirect_to project_path(project)
    end
  end
end
