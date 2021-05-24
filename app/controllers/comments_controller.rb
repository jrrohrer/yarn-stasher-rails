class CommentsController < ApplicationController
  def new
    @project = Project.find_by_id(params[:project_id])
    @comment = @project.comments.build

    # comment belongs to a project
  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end
end
