# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit::Authorization
  include AuthConcern

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
end
