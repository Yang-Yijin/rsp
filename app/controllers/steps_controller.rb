class StepsController < ApplicationController
  before_action :set_recipe
  before_action :require_user
  before_action :require_same_user
  before_action :set_step, only: [ :update, :destroy ]

  def create
    @step = @recipe.steps.new(step_params)
    if @step.save
      flash[:notice] = "Step added successfully"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "Failed to add step"
      redirect_to recipe_path(@recipe)
    end
  end

  def update
    if @step.update(step_params)
      flash[:notice] = "Step updated successfully"
    else
      flash[:alert] = "Failed to update step"
    end
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @step.destroy
    flash[:notice] = "Step deleted"
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_step
    @step = @recipe.steps.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:instructions, :position)
  end

  def require_same_user
    if current_user != @recipe.user
      flash[:alert] = "You can only edit your own recipe"
      redirect_to recipes_path
    end
  end
end
