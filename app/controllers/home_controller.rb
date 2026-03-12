class HomeController < ApplicationController
  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end
end
