class Web::Admin::BulletinsController < Web::AdminController
  before_action :require_admin
  # before_action :set_bulletin, only: %i[ show edit update ]

  # GET /bulletins
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    authorize @bulletins
  end
end
