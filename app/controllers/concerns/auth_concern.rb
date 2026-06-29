# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
    helper_method :require_login
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    return if current_user

    redirect_to root_path, alert: t('.must_be_logged_in')
  end

  def user_not_authorized
    redirect_to root_path, alert: t('.must_be_authorized_user')
  end

  def require_admin
    return if current_user&.admin?

    redirect_to root_path, alert: t('.must_be_admin')
  end
end
