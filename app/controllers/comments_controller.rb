class CommentsController < ApplicationController
  before_action :require_permission, only: [:edit, :update, :destroy]

  def index
    # the only time this will get accessed is if someone views all comments for a project.
    set_project
  end

  def new
    set_project
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
    set_comment
  end

  def edit
    # add protection so only user who owns comment can edit it 
    set_comment
  end

  def update
    # add protection so only user who owns comment can edit it
    comment = Comment.find_by(id: params[:id])
    comment.update(comment_params)
    redirect_to project_comment_path(comment.project_id, comment.id)
  end

  def destroy
    # add flash message for successful delete or error message for unsuccessful delete
    # only the person who made the comment should be able to delete it
    comment = Comment.find_by(id: params[:id])
    project = comment.project_id
    comment.destroy

    redirect_to project_path(project)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :project_id)
  end

  def set_project
    @project = Project.find_by_id(params[:project_id])
  end

  def set_comment
    @comment = Comment.find_by_id(params[:id])
  end

  def require_permission
    comment = Comment.find_by(id: params[:id])
    if comment.user_id != current_user.id
      flash[:error] = 'Only the user who created a comment may edit or delete it.'
      redirect_to comment_path(comment)
    end
  end
end
