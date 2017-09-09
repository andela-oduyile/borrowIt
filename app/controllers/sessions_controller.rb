class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    begin
      user = Slack::Oauth.new(code: params[:code]).authenticate
      @current_user ||= User.from_slack(user)

      redirect_to(frontend_url)
    rescue
      #TODO: this should still redirect to the frontend but with a message that user is not valid
      head 401
    end
  end

  private
    def frontend_url
      token = current_user.api_key
      "#{ FRONTEND_CONFIG.url }?token=#{ token }"
    end
end
