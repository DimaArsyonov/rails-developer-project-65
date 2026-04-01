class Web::BulletinsController < Web::ApplicationController
  before_action :require_login, only: %i[new create edit]
  before_action :set_bulletin, only: %i[ show edit update ]

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
        format.html { redirect_to @bulletin, notice: t(:bulletin_updated), status: :see_other }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
      authorize @bulletin
    end

    # Only allow a list of trusted parameters through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end

    def require_login
      unless current_user
        redirect_to root_path, alert: t(:must_be_logged_in)
      end
    end
end
