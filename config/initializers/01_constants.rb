SLACK_CONFIG = OpenStruct.new({
  app_id: ENV['SLACK_APP_ID'],
  api_secret: ENV['SLACK_API_SECRET'],
  # sign_in_api_key: ENV['SLACK_SIGN_IN_KEY'],
  # sign_in_api_secret: ENV['SLACK_SIGN_IN_SECRET'],
  team: ENV['SLACK_TEAM']
})


FRONTEND_CONFIG = OpenStruct.new({
  url: ENV["FRONTEND_URL"]
})
