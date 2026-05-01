class Web::ProfilesController < Web::ApplicationController
  before_action :require_login

  def show
    @bulletins = current_user.bulletins.order(created_at: :desc)
  end
end
