# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :require_login

  def show
    @q = current_user.bulletins.ransack(params[:q])
    puts params[:q].inspect
    puts @q.result.to_sql
    puts @q.result.count
    @bulletins = @q.result.order(created_at: :desc).page(params[:page]).per(10)
  end
end
