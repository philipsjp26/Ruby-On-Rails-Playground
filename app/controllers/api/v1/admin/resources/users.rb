class Api::V1::Admin::Resources::Users < Grape::API
  resource :users do
    desc "create user"
    params do
      requires :username, type: String
      requires :fullname, type: String
      requires :email, type: String
      requires :password, type: String
      requires :roles, type: Array
    end
    oauth "super_admin"
    post "/create" do
      data = User.find_by(username: params[:username])
      error!("username or data already exist") if data.present?

      data = User.new
      data.username = params[:username]
      data.fullname = params[:fullname]
      data.email = params[:email]
      data.password = Bcrypt::Password.create(params[:password])
      error!(data.errors.full_messages, 422) unless data.save

      data.roles << Role.where(id: [params[:roles]])

      present :users, data, with: Api::V1::Admin::Entities::Users
    end
  end
end
