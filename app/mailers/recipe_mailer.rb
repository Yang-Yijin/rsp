class RecipeMailer < ApplicationMailer
  def new_recipe_notification(recipe)
    @recipe = recipe
    @user = recipe.user
    mail(to: @user.email, subject: "Your new recipe '#{@recipe.title}' has been published!")
  end

  def favorite_notification(favorite)
    @recipe = favorite.recipe
    @user = @recipe.user
    @favorited_by = favorite.user
    mail(to: @user.email, subject: "Your recipe '#{@recipe.title}' was favorited!")
  end
end
