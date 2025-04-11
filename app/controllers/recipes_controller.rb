class RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, except: [ :index, :show ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @recipe = Recipe.new
    3.times { @recipe.ingredients.build }
    3.times { @recipe.steps.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      flash[:notice] = "Recipe created successfully!"
      redirect_to @recipe
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe updated successfully!"
      redirect_to @recipe
    else
      render "edit"
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = "Recipe deleted"
    redirect_to recipes_path
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    if already_favorited?
      flash[:alert] = "You've already favorited this recipe"
    else
      @favorite = current_user.favorites.create(recipe: @recipe)
      flash[:notice] = "Recipe added to favorites!"
    end
    redirect_to recipe_path(@recipe)
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @favorite = current_user.favorites.find_by(recipe: @recipe)
    if @favorite
      @favorite.destroy
      flash[:notice] = "Removed from favorites"
    end
    redirect_to recipe_path(@recipe)
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :cook_time,
                                  ingredients_attributes: [ :id, :name, :quantity, :_destroy ],
                                  steps_attributes: [ :id, :instructions, :position, :_destroy ])
  end

  def require_same_user
    if current_user != @recipe.user
      flash[:alert] = "You can only edit your own recipe"
      redirect_to @recipe
    end
  end

  def already_favorited?
    Favorite.where(user_id: current_user.id, recipe_id: params[:id]).exists?
  end
end
