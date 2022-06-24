module Oauth
  module Authentication
    def oauth(*scopes)
      description = if respond_to?(:route_setting) # >= grape-0.10.0
          route_setting(:description) || route_setting(:description, {})
        else
          @last_description ||= {}
        end

      description[:auth] = { scopes: scopes }
    end

    grape_api = defined?(Grape::API::Instance) ? Grape::API::Instance : Grape::API
    grape_api.extend self
  end
end
