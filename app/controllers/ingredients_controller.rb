class IngredientsController < ApplicationController
  before_action :set_recipe
  before_action :require_user
  before_action :require_same_user
  before_action :set_ingredient, only: [ :update, :destroy ]

  def create
    @ingredient = @recipe.ingredients.new(ingredient_params)
    if @ingredient.save
      flash[:notice] = "Ingredient added successfully"
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "Failed to add ingredient"
      redirect_to recipe_path(@recipe)
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:notice] = "Ingredient updated successfully"
    else
      flash[:alert] = "Failed to update ingredient"
    end
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @ingredient.destroy
    flash[:notice] = "Ingredient deleted"
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient
    @ingredient = @recipe.ingredients.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity)
  end

  def require_same_user
    if current_user != @recipe.user
      flash[:alert] = "You can only modify your own recipes"
      redirect_to recipes_path
    end
  end
end
