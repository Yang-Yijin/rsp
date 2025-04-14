module Api
  module V1
    class UsersController < BaseController
      skip_before_action :authenticate_api_user!, only: [ :show ]

      def show
        @user = User.find(params[:id])
        @recipes = @user.recipes

        render json: {
          user: @user.as_json(only: [ :id, :username, :email, :bio ]),
          recipes: @recipes.as_json(only: [ :id, :title, :description, :cook_time ])
        }
      end
    end
  end
end
