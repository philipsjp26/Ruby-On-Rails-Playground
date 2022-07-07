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
          access = Doorkeeper::AccessToken.find_by(token: @access_token)

          unless access.present?
            raise Oauth::Errors::OAuthUnauthorizedError
          end

          resource_owner_id = access.try(:resource_owner_id)
          user = User.select(:id, :username, :created_at).where(id: [resource_owner_id]).try(:first)

          raise Oauth::Errors::OAuthForbiddenError unless user.present?
          @current_user = user
        else          
          raise Oauth::Errors::OAuthUnauthorizedError
        end
      end

      private

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
