class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private
    def authenticate_user!
      if auth.authenticated?
        current_user
      else
        unauthorized!
      end
    end

    def unauthorized!
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {errors: "Request was made with an invalid token"}, status: 401
    end

    def auth
      @_auth ||= Authenticator.new(request)
    end

    def current_user
      @current_user ||= User.find_by(id: auth.user)
    end
end
