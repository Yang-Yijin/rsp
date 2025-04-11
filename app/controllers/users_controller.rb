class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :require_same_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Recipe Sharing Platform, #{@user.username}!"
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def show
    @recipes = @user.recipes
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully"
      redirect_to @user
    else
      render "edit"
    end
  end

  def favorites
    @recipes = current_user.favorite_recipes
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :bio)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "you can only update your own account"
      redirect_to @user
    end
  end
end
