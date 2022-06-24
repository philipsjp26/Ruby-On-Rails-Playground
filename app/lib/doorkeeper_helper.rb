class DoorkeeperHelper
  class << self
    def access_token(expires_in = 2.hours, resource_owner_id, use_refresh_token)
      token = Doorkeeper::AccessToken.create!(
        application: Doorkeeper::Application.find_by_name("API_RBAC"),
        expires_in: expires_in,
        resource_owner_id: resource_owner_id,
        use_refresh_token: use_refresh_token.present? ? use_refresh_token : false,
      )
      token
    end
  end
end
