class CommentsController < ApplicationController
  def new
    @project = Project.find_by_id(params[:project_id])
    @comment = @project.comments.build

    # comment belongs to a project
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comment_path(@comment)
    else
      render :new 
    end
    
  end

  def show

  end

  def edit

  end

  def update

  end

  private

  def comment_params
    params.require(:comment).permit(:content, :project_id)
  end
end
