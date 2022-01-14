class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  def index
    @users = User.all
    @tasks = Task.all.includes(:user)
  end

  def show
  end

  def new
    @user = User.new
    if check_admin

    else logged_in?
      redirect_to tasks_path
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in
      redirect_to admin_user_path(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザ「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザ「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end

