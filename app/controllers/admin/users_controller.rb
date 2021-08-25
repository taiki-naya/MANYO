class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @user = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.name}'s profile successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.name}'s data was deleted"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
