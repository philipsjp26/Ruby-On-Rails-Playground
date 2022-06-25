module ExceptionHandler
  def self.included(base)
    base.instance_eval do
      rescue_from :all do |e|
        if e.class.name == "Oauth::Errors::OAuthUnauthorizedError"
          code = 401
          message = "Unauthorize"
        elsif e.class.name == "Oauth::Errors::OAuthForbiddenError"
          code = 403
          message = 'Forbidden errors'
        end
        results = {
          code: code,
          messages: message,
        }

        rack_response results.to_json, code
      end
    end
  end
end
