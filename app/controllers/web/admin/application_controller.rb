# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  before_action :require_admin
  layout 'web/admin/application'
end
