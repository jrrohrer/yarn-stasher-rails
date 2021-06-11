class YarnsController < ApplicationController
  before_action :require_permission, only:[:edit, :update, :destroy]

  def new
    @yarn = Yarn.new
    @yarn.build_project
  end

  def create
    #@yarn = Yarn.new(yarn_params)
    #@yarn.user_id = session[:user_id]
    @yarn = current_user.yarns.create(yarn_params) # replaces previous two lines; makes following if statement unneccessary
   
    if @yarn.project
      @yarn.project.user_id = session[:user_id]
    end

    #@yarn.save (don't need this now; line 13 creates and saves if valid)
    if @yarn.save
      flash[:message] = 'Yarn successfully created!'
      redirect_to yarn_path(@yarn)
    else
      render :new
    end
  end

  def show
    set_yarn
  end 
  
  def edit
    set_yarn
  end

  def update
    yarn = Yarn.find_by(id: params[:id])
    yarn.update(yarn_params)
    flash[:message] = 'Yarn successfully updated!'
    redirect_to yarn_path(yarn)
  end

  def destroy
    yarn = Yarn.find_by(id: params[:id])
    yarn.destroy
    flash[:message] = 'Yarn successfully deleted!'
    redirect_to user_path(current_user)
  end


  private

  def yarn_params
    params.require(:yarn).permit(
      :brand_name, 
      :colorway, 
      :fiber, 
      :weight, 
      :yardage, 
      :quantity,
      :user_id,
      :project_id, 
      project_attributes: [:title, :pattern_name, :designer, :craft, :tool_size]
    )
  end

  def set_yarn
    @yarn = Yarn.find_by(id: params[:id])
  end

  def require_permission
    yarn = Yarn.find_by(id: params[:id])
    if yarn.user_id != current_user.id
      flash[:error] = 'Only the user who created a yarn may edit or delete it.'
      redirect_to yarn_path(yarn)
    end
  end
end