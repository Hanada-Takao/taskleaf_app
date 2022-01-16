module SessionsHelper

  def log_in
    session[:user_id] = @user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      #@current_user = @current_user || User.find_by(id: session[:user_id])と同じ意味
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user?
    @user == @current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end

  #管理者権限がないユーザーを弾く
  def check_admin
    current_user.admin?
  end
end
