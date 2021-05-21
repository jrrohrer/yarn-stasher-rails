class YarnsController < ApplicationController

  def new
    @yarn = Yarn.new
    @yarn.build_project
  end

  def create
    @yarn = Yarn.new(yarn_params)
    @yarn.user_id = session[:user_id]
    @yarn.save
    if @yarn.save
      redirect_to yarn_path(@yarn)
    else
      #redirect_to new_yarn_path
    end
  end

  def show
    @yarn = Yarn.find_by(params[:yarn_id])
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
      :project_id
      #project_attributes: [
       # :title,
       # :pattern_name,
       # :designer,
       # :craft,
       # :tool_size
      #]
    )
  end
end
