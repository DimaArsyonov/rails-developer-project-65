Sentry.init do |config|
  config.dsn = "https://898c4740e5931a7a05c02f8d2e4d5374@o4510127544991744.ingest.us.sentry.io/4510127549972480"
  # get breadcrumbs from logs
  config.breadcrumbs_logger = [ :active_support_logger, :http_logger ]
  # Add data like request headers and IP for users, if applicable;
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
