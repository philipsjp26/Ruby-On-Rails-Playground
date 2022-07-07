class Api::V1::Admin::Resources::Roles < Grape::API
  resource :roles do
    desc "List roles"
    get "/list" do
      data = paginate Role.all.select(:id, :name)
      present :roles, data
    end
    desc "Edit roles"
    params do
      requires :id, type: Integer, desc: "Role id"
      requires :name, type: String
    end
    oauth "super_admin"
    put "/edit/:id" do
      role = Role.find_by(id: params.id)
      error!("Role not found", env["api.response.code"] = 422) unless role.present?
      role.build(name: params.name).try(:save!)
      present :roles, role, with: Api::V1::Admin::Entities::Roles
    end
  end
end
