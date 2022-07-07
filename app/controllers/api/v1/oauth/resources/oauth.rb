class Api::V1::Oauth::Resources::Oauth < Grape::API
  resource :oauth do
    desc "Login access"
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post "/login" do
      user = User.find_by_username(params.username)
      error!("username not found", env["api.response.code"] = 422) if user.nil?

      token = DoorkeeperHelper.access_token(user.id, true)

      present :access_token, token, with: Api::V1::Oauth::Entities::Oauth
    end

    desc "Get me"
    oauth "super_admin", "admin", "public"
    get "/me" do
      present :me, current_user, with: Api::V1::Oauth::Entities::Me
    end

    desc "Logout"
    params do
      requires :client_id, type: String
      requires :client_secret, type: String
    end
    oauth "super_admin"
    post "/logout" do
      app = DoorkeeperHelper.destroy(params.client_id, params.client_secret, current_user)
      statusCode, message = app
      error!(message, statusCode) if statusCode == 422

      present :oauth, "Success Logout"
    end
  end
end
