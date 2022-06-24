module AuthMethods
  module CustomAuth
    def set_current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user
    end

    def protected_endpoint=(protected)
      @protected_endpoint = protected
    end

    def protected_endpoint?
      @protected_endpoint || false
    end
  end
end
