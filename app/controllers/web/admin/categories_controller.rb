# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::ApplicationController
  before_action :require_admin

  # GET /categories
  def index
    @categories = Category.order(id: :asc).page(params[:page]).per(10)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.category_created')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.category_updated')
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_categories_path, notice: t('.category_deleted')
    else
      redirect_to admin_categories_path, alert: t('.category_not_deleted')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
