class Web::Admin::BulletinsController < Web::AdminController
  before_action :require_admin
  # before_action :set_bulletin, only: %i[ show edit update ]

  # GET /bulletins
  def index
    @bulletins = Bulletin.order(created_at: :desc)
    authorize @bulletins
  end
end
