class Api::V1::Admin::Resources::Menus < Grape::API
  resource :menus do
    desc "List menu"
    get "/list" do
      menu = paginate Menu.all
      present :menus, menu, with: Api::V1::Admin::Entities::Menus
    end
  end
end
