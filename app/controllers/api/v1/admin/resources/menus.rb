class Api::V1::Admin::Resources::Menus < Grape::API
  resource :menus do
    desc "create menu"
    params do
      requires :name, type: String
    end
    oauth "super_admin"
    post "/create" do
      menu = Menu.find_by(name: params[:name])
      error!("Menu already exists") if menu.present?

      menu = Menu.new
      menu.name = params[:name]
      menu.save

      present :menus, menu, with: Api::V1::Admin::Entities::Menus
    end

    desc "List menu"
    get "/list" do
      menu = paginate Menu.all
      present :menus, menu, with: Api::V1::Admin::Entities::Menus
    end
  end
end
