module Api
  module Helpers
    module AuthHelper
      def encode_token(payload)
        data = Base64.strict_encode64(payload.to_json)
        signature = OpenSSL::HMAC.hexdigest('SHA256', "testing", data)
        "#{data}.#{signature}"
      end

      def decode_token(token)
        data, signature = token.split('.')
        return nil unless signature == OpenSSL::HMAC.hexdigest('SHA256', "testing", data)

        JSON.parse(Base64.decode64(data))
      rescue
        nil
      end

      def current_user
        token = headers['Authorization']&.split&.last
        decoded = decode_token(token)
        @current_user ||= User.find_by(id: decoded['user_id']) if decoded
      end

      def authenticate!
        env['api.response.code'] = 401
        error!('Unauthorized', 401) unless current_user
      end
    end
  end
end
