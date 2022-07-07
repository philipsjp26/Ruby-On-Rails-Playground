class Api::V1::Admin::Resources::Users < Grape::API
  helpers do
    def find_user(username)
      user = User.find_by(username: username)
      user
    end

    def find_menu(menu_id)
      menu = Menu.find_by(id: menu_id)
      error!("Menu not found", env["api.response.code"] = 422) unless menu.present?
      menu
    end
  end
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
      user = find_user(params[:username])
      error!("username or data already exist", env["api.response.code"] = 422) if user.present?
      data = User.new
      data.username = params[:username]
      data.fullname = params[:fullname]
      data.email = params[:email]
      data.password = BCrypt::Password.create(params[:password])
      error!(data.errors.full_messages, 422) unless data.save

      data.roles << Role.where(id: [params[:roles]])

      present :users, data, with: Api::V1::Admin::Entities::Users
    end

    desc "List users"
    params do
      optional :q, type: String
      optional :start_date, type: Date
      optional :end_date, type: Date
    end
    get "/list" do
      data = User.list(params)
      present :users, data, with: Api::V1::Admin::Entities::Users
    end

    desc "Edit users"
    params do
      requires :username, type: String
      optional :fullname, type: String
      optional :roles, type: Array
      optional :menu_access, type: Array[JSON] do
        requires :menu_id, type: Integer
        requires :actions, type: JSON
      end
    end
    put "/edit" do
      user = find_user(params[:username])
      error!("username or data already exist", env["api.response.code"] = 422) unless user.present?
      if user.menu_actions.present? && params.menu_access.present?
        params[:menu_access].each do |v|
          menu = find_menu(v.menu_id)

          actions = user.menu_actions.where(menu_id: v.menu_id)
          actions.update(actions: v.actions)
        end
      else
        if params.menu_access.present?
          params[:menu_access].each do |v|
            menu = find_menu(v.menu_id)
            user.menu_actions.build(menu: menu, actions: v.actions).try(:save!)
          end
        end
      end

      user.roles << Role.where(id: params[:roles]) unless user.roles.present?

      env["api.response.message"] = "Success update data"
      present :users, true
    end
  end
end
