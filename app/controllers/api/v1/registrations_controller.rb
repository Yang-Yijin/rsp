module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      private

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {
            status: { code: 200, message: "Signed up successfully" },
            data: {
              user: {
                id: resource.id,
                email: resource.email,
                username: resource.username
              }
            }
          }
        else
          render json: {
            status: { message: resource.errors.full_messages.join(", ") }
          }, status: :unprocessable_entity
        end
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :username, :bio)
      end
    end
  end
end
