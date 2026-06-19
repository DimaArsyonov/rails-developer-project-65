# frozen_string_literal: true

class Web::Admin::AdminController < Web::ApplicationController
  before_action :require_admin

  def index
    @bulletins = Bulletin.where(state: :under_moderation).order(created_at: :desc)
                         .page(params[:page]).per(10)
  end
end
