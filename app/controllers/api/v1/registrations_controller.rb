module Api
  module V1
    class RegistrationsController < BaseController
      skip_before_action :authenticate_api_user!, only: [ :create ]

      def create
        @user = User.new(sign_up_params)

        if @user.save

          @client_id = SecureRandom.urlsafe_base64(nil, false)
          @token = SecureRandom.urlsafe_base64(nil, false)
          @expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i


          @user.tokens = {} if @user.tokens.nil?
          @user.tokens[@client_id] = {
            token: BCrypt::Password.create(@token),
            expiry: @expiry
          }
          @user.save


          response.headers["access-token"] = @token
          response.headers["client"] = @client_id
          response.headers["expiry"] = @expiry
          response.headers["uid"] = @user.uid || @user.email
          response.headers["token-type"] = "Bearer"

          render json: {
            status: { code: 200, message: "Signup susscefully" },
            data: {
              id: @user.id,
              email: @user.email,
              username: @user.username,
              uid: @user.uid || @user.email
            }
          }, status: :ok
        else
          render json: {
            status: { code: 422, message: @user.errors.full_messages.join(", ") }
          }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :username, :bio)
      end
    end
  end
end
