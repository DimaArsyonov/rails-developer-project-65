# frozen_string_literal: true

module ApplicationHelper
  def map_alert_type(type)
    map = {
      notice: 'info',
      error: 'danger',
      success: 'success'
    }
    map.fetch(type.to_sym, 'info')
  end
end
