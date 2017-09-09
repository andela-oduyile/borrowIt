class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private
    def authenticate_user!
      valid_request? || unauthorized!
    end

    def unauthorized!
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: {errors: "Request was made with an invalid token"}, status: 401
    end

    def valid_request?
      @current_user ||= User.find_by(id: user_hash["user"]) if reqd_params_present?
    end

    def token
      @_token ||= params[:token]
    end

    def user_hash
      @_user_hash ||= JWTService.authenticate(token)
    end

    def reqd_params_present?
      token.present? && user_hash.present?
    end

    def current_user
      @current_user ||= User.find_by(id: user_hash["user"])
    end
end
