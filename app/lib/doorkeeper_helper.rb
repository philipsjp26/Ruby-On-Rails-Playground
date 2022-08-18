class DoorkeeperHelper
  class << self
    def access_token(expires_in = 2.hours, resource_owner_id, use_refresh_token)
      token = Doorkeeper::AccessToken.create!(
        application: Doorkeeper::Application.find_by_name("playground"),
        expires_in: expires_in,
        resource_owner_id: resource_owner_id,
        use_refresh_token: use_refresh_token.present? ? use_refresh_token : false,
      )
      token
    end

    def destroy(client_id, client_secret = nil, user)
      app = Doorkeeper::Application.where(uid: client_id).try(:first)
      if app.nil?
        return 422, "application not found"
      else
        user.logout
      end
    end
  end
end
