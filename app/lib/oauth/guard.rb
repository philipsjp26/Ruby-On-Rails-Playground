module Oauth
  module Guard
    class Oauth2 < Grape::Middleware::Base
      attr_reader :auth_strategy

      def context
        env["api.endpoint"]
      end

      def doorkeeper_request=(env)
        @_doorkeeper_request = ActionDispatch::Request.new(env)
      end

      def request
        @_doorkeeper_request
      end

      def endpoint_protected?
        has_auth_scopes?
      end

      def before
        AuthStrategies.api_context = context
        return unless endpoint_protected?
        context.extend(Oauth::AuthMethods::CustomAuth)
        self.doorkeeper_request = env

        context.set_current_user = authenticate
      end

      def authenticate
        if request.headers["Authorization"].present?
          @access_token = request.headers["Authorization"].try("split", "Bearer").try(:last).try(:strip)
          # access = Doorkeeper::AccessToken.find_by(token: @access_token)
          res = OauthService.credential(@access_token)
          unless res.code.to_i == 200
            raise Oauth::Errors::OAuthUnauthorizedError
          end
          res = JSON.parse(res)
          user = res.try(:[], "data").try(:[], "user")
          credential = res.try(:[], "data").try(:[], "credential")

          agent = Agent.find_by(privy_id: user.try(:[], "privy_id"), enable: true)
          if agent.present?
            agent.access_token = credential.try(:[], "access_token")
            agent.name = user.try(:[], "name")
            agent.save
          else
            raise Oauth::Errors::OAuthForbiddenError
          end
          raise Oauth::Errors::OAuthForbiddenError if valid_roles(agent) == 0
          @current_user = agent
        else
          raise Oauth::Errors::OAuthUnauthorizedError
        end
      end

      private

      def valid_roles(agent)
        scope = auth_scopes()

        matching = false
        role = agent.try(:roles)

        role.each do |r|
          if scope.include? r.code.to_sym
            matching = true
          end
        end
        return 0 unless matching
        return 1
      end

      def has_auth_scopes?
        endpoint_authorizations &&
          endpoint_authorizations.key?(:scopes) &&
          endpoint_authorizations[:scopes].any?
      end

      def auth_scopes
        endpoint_authorizations[:scopes].map(&:to_sym)
      end

      private

      def endpoint_authorizations
        context.options[:route_options][:auth]
      end
    end
  end
end
