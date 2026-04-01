class Web::AdminController < Web::ApplicationController
  before_action :require_admin
  # before_action :set_bulletin, only: %i[ show edit update ]

  # GET /admin
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  private
    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: t(:must_be_admin)
      end
    end
end
