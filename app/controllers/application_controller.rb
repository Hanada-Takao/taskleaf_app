class ApplicationController < ActionController::Base
  # helper_method :current_user
  before_action :login_required
  include SessionsHelper

  private

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end

  def login_required
    redirect_to login_path unless current_user
  end

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end
end
