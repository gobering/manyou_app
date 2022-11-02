class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all.includes(:task)
  end

  def new 
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user), notice: "ユーザー情報を登録しました"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      redirect_to edit_admin_user_path(@user)
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー情報を消去しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
    

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
