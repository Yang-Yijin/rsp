module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_user!
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      def not_found
        render json: { error: "Resource not found" }, status: :not_found
      end
    end
  end
end
