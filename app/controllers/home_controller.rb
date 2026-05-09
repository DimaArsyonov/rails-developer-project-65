class HomeController < ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result.published.order(created_at: :desc)
  end
end
