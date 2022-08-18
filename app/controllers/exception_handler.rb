module ExceptionHandler
  def self.included(base)
    base.instance_eval do
      rescue_from :all do |e|
        if e.class.name == "Grape::Exceptions::ValidationErrors"
          code = 422
          message = e.as_json_custom
        elsif e.class.name == "Oauth::Errors::OAuthForbiddenError"
          code = 403
          message = "Forbidden access"
        elsif e.class.name == "Oauth::Errors::OAuthUnauthorizedError"
          code = 401
          message = "Unauthorize"
        elsif e.class.name == "Grape::Exceptions::MethodNotAllowed"
          code = 405
          message = "Method not allowed"
        else
          code = 500
          message = e.message
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
