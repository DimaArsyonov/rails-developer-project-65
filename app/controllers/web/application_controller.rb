class Web::ApplicationController < ApplicationController
  include Pundit

  helper_method :current_user
  helper_method :require_login

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless current_user
      redirect_to root_path, alert: t(:must_be_logged_in)
    end
  end

  def user_not_authorized
    redirect_to root_path, alert: t(:must_be_authorized_user)
  end
end
