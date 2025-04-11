module Api
  module V1
    class RecipesController < BaseController
      before_action :set_recipe, only: [ :show, :update, :destroy ]
      before_action :check_owner, only: [ :update, :destroy ]
      skip_before_action :authenticate_user!, only: [ :index, :show ]

      # GET /api/v1/recipes
      def index
        @recipes = Recipe.all.includes(:user).order(created_at: :desc)
        render json: {
          recipes: @recipes.as_json(include: { user: { only: [ :id, :username ] } })
        }
      end

      # GET /api/v1/recipes/:id
      def show
        render json: {
          recipe: @recipe.as_json(
            include: {
              user: { only: [ :id, :username ] },
              ingredients: { only: [ :id, :name, :quantity ] },
              steps: { only: [ :id, :instructions, :position ] }
            }
          )
        }
      end

      # POST /api/v1/recipes
      def create
        @recipe = current_user.recipes.build(recipe_params)

        if @recipe.save
          # 发送新食谱邮件通知
          RecipeMailer.new_recipe_notification(@recipe).deliver_later
          render json: {
            message: "Recipe created successfully",
            recipe: @recipe.as_json
          }, status: :created
        else
          render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/recipes/:id
      def update
        if @recipe.update(recipe_params)
          render json: {
            message: "Recipe updated successfully",
            recipe: @recipe.as_json
          }
        else
          render json: { errors: @recipe.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/recipes/:id
      def destroy
        @recipe.destroy
        render json: { message: "Recipe deleted successfully" }
      end

      private

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def check_owner
        unless @recipe.user == current_user
          render json: { error: "You are not authorized to perform this action" }, status: :forbidden
        end
      end


      def recipe_params
        params.require(:recipe).permit(:title, :description, :cook_time, :image,
          ingredients_attributes: [ :id, :name, :quantity, :_destroy ],
          steps_attributes: [ :id, :instructions, :position, :_destroy ])
      end
    end
  end
end
