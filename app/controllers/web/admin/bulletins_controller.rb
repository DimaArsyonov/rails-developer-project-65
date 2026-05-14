class Web::Admin::BulletinsController < Web::AdminController
  before_action :require_admin
  before_action :set_bulletin, only: %i[ publish reject archive ]


  # GET /bulletins
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    authorize @bulletins
  end

  def publish
    if @bulletin.publish!
      redirect_back fallback_location: root_path, notice: t(:bulletin_published)
    else
      redirect_back fallback_location: root_path, alert: t(:bulletin_not_published)
    end
  end

  def reject
    if @bulletin.reject!
      redirect_back fallback_location: root_path, notice: t(:bulletin_rejected)
    else
      redirect_back fallback_location: root_path, alert: t(:bulletin_not_rejected)
    end
  end

  def archive
    if @bulletin.archive!
      redirect_back fallback_location: root_path, notice: t(:bulletin_archived)
    else
      redirect_back fallback_location: root_path, alert: t(:bulletin_not_archived)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    def set_categories
      @categories = Category.all
    end

    # Only allow a list of trusted parameters through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
end
