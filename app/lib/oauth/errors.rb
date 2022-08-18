module Oauth
  module Errors
    class BaseError < StandardError
      def initialize(message)
        super(message)
      end
    end

    class OAuthUnauthorizedError < BaseError
      def initialize
        super("Invalid access token")
      end
    end

    class OAuthForbiddenError < BaseError
      def initialize
        super("Forbidden access")
      end
    end
  end
end
