# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit::Authorization
  include AuthConcern

  allow_browser versions: :modern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
end
