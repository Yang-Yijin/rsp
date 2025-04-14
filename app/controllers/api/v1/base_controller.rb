module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      include DeviseTokenAuth::Concerns::SetUserByToken if defined?(DeviseTokenAuth)
      skip_before_action :verify_authenticity_token
      before_action :authenticate_api_user!
      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

      def not_found
        render json: { error: "Resource not found" }, status: :not_found
      end

      def authenticate_api_user!
        unless current_api_user
          render json: { error: "Unauthorized access" }, status: :unauthorized
        end
      end

      def current_api_user
        @current_api_user ||= begin
          uid = request.headers["uid"]
          token = request.headers["access-token"]
          client = request.headers["client"]

          user = User.find_by(email: uid) if uid.present?

          if user && user.tokens.present? && user.tokens[client].present?
            user_token = user.tokens[client]["token"]
            user_expiry = user.tokens[client]["expiry"]

            if user_expiry.to_i > Time.now.to_i

              user
            end
          end
        end
      end
    end
  end
end
