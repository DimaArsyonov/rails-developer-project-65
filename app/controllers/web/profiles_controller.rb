# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :require_login

  def show
    @q = current_user.bulletins.ransack(params[:q])
    Rails.logger.debug params[:q].inspect
    Rails.logger.debug @q.result.to_sql
    Rails.logger.debug @q.result.count
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
  end
end
