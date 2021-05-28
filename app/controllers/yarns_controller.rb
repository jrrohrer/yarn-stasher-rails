class YarnsController < ApplicationController

  def new
    @yarn = Yarn.new
    @yarn.build_project
  end

  def create
    @yarn = Yarn.new(yarn_params)
    @yarn.user_id = session[:user_id]
    if @yarn.project
      @yarn.project.user_id = session[:user_id]
    end
    # is there a better way to do this???? using build method to associate the yarn to a user broke things, and i didn't know how to get the yarn's user_id into the attributes for the project...
    @yarn.save
    if @yarn.save
      redirect_to yarn_path(@yarn)
    else
      render :new
    end
  end

  def show
    set_yarn
  end

  def edit
    # add protection so only user who owns yarn can edit it
    set_yarn
  end

  def update
    # add protection so only user who owns yarn can edit it
    yarn = Yarn.find_by(id: params[:id])
    yarn.update(yarn_params)
    redirect_to yarn_path(yarn)
  end

  def destroy
    # add protection so only user who owns yarn can delete it
    yarn = Yarn.find_by(id: params[:id])
    yarn.destroy
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
end