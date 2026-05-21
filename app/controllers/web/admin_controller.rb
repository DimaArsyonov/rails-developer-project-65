# frozen_string_literal: true

module Web
  class AdminController < Web::ApplicationController
    before_action :require_admin

    def index
      @bulletins = Bulletin.where(state: :under_moderation).order(created_at: :desc)
                           .page(params[:page]).per(10)
    end

    private

    def require_admin
      return if current_user&.admin?

      redirect_to root_path, alert: t(:must_be_admin)
    end
  end
end
