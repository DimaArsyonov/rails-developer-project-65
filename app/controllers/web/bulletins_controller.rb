class Web::BulletinsController < Web::ApplicationController
  before_action :require_login, only: %i[new create edit]
  before_action :set_categories, only: %i[new edit create update]
  before_action :set_bulletin, only: %i[ show edit update to_moderate publish reject archive ]

  # GET /bulletins or /bulletins.json
  def index
    @bulletins = Bulletin.order(created_at: :desc)
    authorize @bulletins
  end

  # GET /bulletins/1 or /bulletins/1.json
  def show
  end

  # GET /bulletins/new
  def new
    @bulletin = Bulletin.new
    @categories = Category.all
    authorize @bulletin
  end

  # GET /bulletins/1/edit
  def edit
  end

  # POST /bulletins or /bulletins.json
  def create
    @bulletin = Bulletin.new(bulletin_params)
    @categories = Category.all
    @bulletin.user = current_user
    authorize @bulletin

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to @bulletin, notice: t(:bulletin_created) }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulletins/1 or /bulletins/1.json
  def update
    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to profile_path, notice: t(:bulletin_updated), status: :see_other }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  def publish
    if @bulletin.publish!
      redirect_back fallback_location: root_path, notice: t(:bulletin_published)
    else
      redirect_back fallback_location: root_path, alert: t(:bulletin_not_published)
    end
  end

  def to_moderate
    if @bulletin.to_moderate!
      redirect_back fallback_location: root_path, notice: t(:bulletin_sent_to_moderation)
    else
      redirect_back fallback_location: root_path, alert: t(:bulletin_not_sent_to_moderation)
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
