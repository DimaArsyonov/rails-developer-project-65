class Web::Admin::CategoriesController < Web::AdminController
  before_action :require_admin
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories
  def index
    @categories = Category.order(id: :asc)
  end

  def new
    @category = Category.new
  end

  def show
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t(:category_created)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t(:category_updated)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: t(:category_deleted)
    else
      redirect_to admin_categories_path, alert: t(:category_not_deleted)
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
