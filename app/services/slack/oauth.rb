class Slack::Oauth
  require 'net/http'
  attr_reader :code, :callback_url

  def initialize(code:, callback_url: ENV['slack_callback_url'])
    @code = code
    @callback_url= callback_url
  end

  def authenticate
    uri = oauth_access_uri
    uri.query = encoded_access_token_query
    response = Net::HTTP.get_response(uri)

    AuthValidator.validate!(response.body)
  end

  private
    def encoded_access_token_query
      URI.encode_www_form(access_token_params)
    end

    def access_token_params
      {
        client_id: SLACK_CONFIG.app_id,
        client_secret: SLACK_CONFIG.api_secret,
        code: code,
        redirect_uri: callback_url
      }
    end

    def oauth_access_uri
      URI("https://slack.com/api/oauth.access")
    end

  class AuthValidator
    class << self
      def validate!(response)
        auth = new(response)

        if auth.valid?
          auth.get_user
        else
          invalid_user!
        end
      end

      def invalid_user!
        raise InvalidUserError
      end
    end

    def initialize(response)
      @response = JSON.parse(response)
    end

    def valid?
      # we may want to add an additional validation to ensure the user is active
      team['id'] == SLACK_CONFIG.team &&
      user['name'].present? &&
      user['id'].present? &&
      user['email'].present?
    end

    def get_user
      {
        provider_id: user["id"],
        name: user["name"],
        email: user["email"]
      }
    end

    private
      attr_reader :response, :user, :team

      def team
        @_team ||= response['team']
      end

      def user
        @_user ||= response['user']
      end
  end

  class InvalidUserError < StandardError; end;
end
