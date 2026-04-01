class Web::Admin::CategoriesController < Web::AdminController
  before_action :require_admin
  # before_action :set_bulletin, only: %i[ show edit update ]

  # GET /categories
  def index
    @categories = Category.order(created_at: :desc)
  end
end
