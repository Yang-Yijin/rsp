module Api
  module V1
    class FavoritesController < BaseController
      # GET /api/v1/favorites
      def index
        @favorites = current_user.favorite_recipes
        render json: {
          favorites: @favorites.as_json(include: { user: { only: [ :id, :username ] } })
        }
      end

      # POST /api/v1/recipes/:id/favorite

      def create
        @recipe = Recipe.find(params[:id])

        if current_user.favorite_recipes.include?(@recipe)
          render json: { message: "Recipe already favorited" }, status: :unprocessable_entity
        else
          @favorite = current_user.favorites.create(recipe: @recipe)
          # 发送收藏邮件通知
          RecipeMailer.favorite_notification(@favorite).deliver_later
          render json: { message: "Recipe favorited successfully" }, status: :created
        end
      end

      # DELETE /api/v1/recipes/:id/unfavorite
      def destroy
        @recipe = Recipe.find(params[:id])
        @favorite = current_user.favorites.find_by(recipe: @recipe)

        if @favorite
          @favorite.destroy
          render json: { message: "Recipe unfavorited successfully" }
        else
          render json: { error: "Recipe not in favorites" }, status: :not_found
        end
      end
    end
  end
end
