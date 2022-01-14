class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if check_admin
    @users = User.all
    @tasks = Task.all.includes(:user)
    else
      redirect_to tasks_path, notice: "管理者以外はアクセスできません。"
    end
  end

  def show
    if check_admin || current_user?
      render :show
    else
      redirect_to tasks_path, notice: "自分以外のユーザマイページにはアクセスできません。"
    end
  end

  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def edit
    # if current_user?
    # else
    #   redirect_to tasks_path, notice: "自分以外の編集はできません。"
    # end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in
      redirect_to user_path(@user), notice: "ユーザ「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザ「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "ユーザ「#{@user.name}」を削除しました。"
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

