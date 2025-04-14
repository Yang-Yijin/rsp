class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform this action"
      redirect_to login_path
    end
  end
end
