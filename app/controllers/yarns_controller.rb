class YarnsController < ApplicationController

  def new
    @yarn = Yarn.new
  end

  def create
    byebug
    @yarn = Yarn.new(yarn_params)
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
      :quantity
    )
  end
end
