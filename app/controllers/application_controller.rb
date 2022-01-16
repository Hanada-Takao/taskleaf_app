class ApplicationController < ActionController::Base
  # helper_method :current_user
  before_action :login_required
  include SessionsHelper

  private

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
