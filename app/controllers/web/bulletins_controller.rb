# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :require_login, only: %i[new create edit to_moderate archive]

  # GET /bulletins or /bulletins.json
  def index
    @categories = Category.all
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.published.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /bulletins/1 or /bulletins/1.json
  def show
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  # GET /bulletins/new
  def new
    @bulletin = Bulletin.new
    @categories = Category.all
    authorize @bulletin
  end

  # GET /bulletins/1/edit
  def edit
    @categories = Category.all
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  # POST /bulletins or /bulletins.json
  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    @categories = Category.all
    authorize @bulletin

    if @bulletin.save
      redirect_to profile_path, notice: t(:bulletin_created)
      render :show, status: :created, location: @bulletin
    else
      render :new, status: :unprocessable_content
      render json: @bulletin.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /bulletins/1 or /bulletins/1.json
  def update
    @categories = Category.all
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t(:bulletin_updated), status: :see_other
      render :show, status: :ok, location: @bulletin
    else
      render :edit, status: :unprocessable_content
      render json: @bulletin.errors, status: :unprocessable_content
    end
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    if @bulletin.to_moderate!
      redirect_back_or_to root_path, notice: t(:bulletin_sent_to_moderation)
    else
      redirect_back_or_to root_path, alert: t(:bulletin_not_sent_to_moderation)
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    if @bulletin.archive!
      redirect_back_or_to root_path, notice: t(:bulletin_archived)
    else
      redirect_back_or_to root_path, alert: t(:bulletin_not_archived)
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
