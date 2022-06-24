class AuthStrategies
  class << self
    attr_accessor :api_context

    def endpoint_protected?
      has_authorizations?
    end

    def auth_scopes
      endpoint_authorizations[:scopes].map(&:to_sym)
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

    def nil_authorizations?
      endpoint_authorizations.nil?
    end

    def has_authorizations?
      (nil_authorizations? || !!endpoint_authorizations) && scope_keys?
    end

    # if false or nil scopes are entered the authorization should be skipped.
    # nil_authorizations? is used to check against the legacy hash.
    def scope_keys?
      nil_authorizations? || endpoint_authorizations[:scopes] != [false]
    end

    def endpoint_authorizations
      api_context.options[:route_options][:auth]
    end
  end
end
