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
    @project.user_id = session[:user_id] 

    @project.save
    if @project.save
      flash[:message] = 'Project created successfully.'
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    set_project
  end

  def edit
    set_project
  end

  def update
    project = Project.find_by(id: params[:id])
    project.update(project_params)
    flash[:message] = 'Project updated successfully.'
    redirect_to project_path(project)
  end

  def destroy
    project = Project.find_by(id: params[:id])
    project.destroy
    flash[:message] = 'Project deleted successfully.'
    redirect_to user_path(current_user)
  end

  private

  def project_params
    params.require(:project).permit(:title, :pattern_name, :designer, :craft, :tool_size, :user_id, yarn_ids: [])
  end

  def require_permission
    project = Project.find_by(id: params[:id])
    if project.user_id != current_user.id
      flash[:error] = 'Only the user who created a project may edit or delete it.'
      redirect_to project_path(project)
    end
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end
end
