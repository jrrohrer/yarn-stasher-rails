class CommentsController < ApplicationController
  def index
    @project = Project.find_by_id(params[:project_id])
  end

  def new
    @project = Project.find_by_id(params[:project_id])
    @comment = @project.comments.build
  end

  def create
    @comment = current_user.comments.build(comment_params)
    # this line creates a new comment linked to a user without adding a 2nd line of code to do so separately. 
    if @comment.save
      redirect_to comment_path(@comment)
    else
      render :new 
    end
    
  end

  def show
    @comment = Comment.find_by_id(params[:id])
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
