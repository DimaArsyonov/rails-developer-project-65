# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::ApplicationController
  before_action :require_admin

  # GET /bulletins
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
    authorize @bulletins
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    if @bulletin.publish!
      redirect_back_or_to root_path, notice: t(:bulletin_published)
    else
      redirect_back_or_to root_path, alert: t(:bulletin_not_published)
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    if @bulletin.reject!
      redirect_back_or_to root_path, notice: t(:bulletin_rejected)
    else
      redirect_back_or_to root_path, alert: t(:bulletin_not_rejected)
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
