class Api::V1::Oauth::Resources::Oauth < Grape::API
  resource :oauth do
    desc "Login access"
    params do
      requires :username, type: String
      requires :password, type: String
    end
    post "/login" do
      user = User.find_by_username(params.username)
      error!("username not found", 422) if user.nil?

      token = DoorkeeperHelper.access_token(user.id, true)

      present :access_token, token, with: Api::V1::Oauth::Entities::Oauth
    end
  end
end
