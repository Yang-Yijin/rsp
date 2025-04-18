# module Api
# module V1
#    class SessionsController < BaseController
#      skip_before_action :authenticate_api_user!, only: [ :create ]
#
#      def create
#        @user = User.find_by(email: params[:email])
#
#        if @user && @user.valid_password?(params[:password])
#          @client_id = SecureRandom.urlsafe_base64(nil, false)
#          @token = SecureRandom.urlsafe_base64(nil, false)
#          @expiry = (Time.now + DeviseTokenAuth.token_lifespan).to_i


#          @user.tokens = {} if @user.tokens.nil?
#          @user.tokens[@client_id] = {
#            token: BCrypt::Password.create(@token),
#            expiry: @expiry
#          }
#          @user.save


#          response.headers["access-token"] = @token
#          response.headers["client"] = @client_id
#          response.headers["expiry"] = @expiry
#          response.headers["uid"] = @user.uid || @user.email
#          response.headers["token-type"] = "Bearer"

#          render json: {
#            status: { code: 200, message: "login in successfully" },
#            data: {
#              id: @user.id,
#              email: @user.email,
#              username: @user.username
#            }
#          }
#        else
#          render json: {
#            status: { code: 401, message: "invalid" }
#          }, status: :unauthorized
#        end
#      end

#      def destroy
#        @user = current_api_user

#        if @user
#          client_id = request.headers["client"]
#          @user.tokens.delete(client_id) if @user.tokens.present?
#          @user.save

#          render json: { status: 200, message: "log off successfully" }
#        else
#          render json: { status: 404, message: "not found" }, status: :not_found
#        end
#      end
#    end
#  end
# end


class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.valid_password?(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user_path(user)
    else
      flash.now[:alert] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
