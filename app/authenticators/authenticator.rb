class Authenticator
  attr_reader :request, :user

  def initialize(request)
    @request = request
  end

  def authenticated?
    return false unless required_params_present?
    strategy, token = request.headers['Authorization'].split
    # only accept bearer tokens
    valid_strategy?(strategy) && valid_token?(token)
  end

  def valid_strategy?(strategy)
    strategy === 'Bearer'
  end

  def valid_token?(token)
    user_hash = JWTService.authenticate(token)
    @user = user_hash["user"]
  end

  def required_params_present?
    request.headers['Authorization'].present?
  end
end
