class Admin::Api::V1::Roles::Resources::Role < Grape::API
  helpers do
    def findRole(id)
      role = Role.find_by(id: id)
      error!("Role not found", env["api.response.code"] = 422) unless role.present?
      role
    end
  end
  resource "roles" do
    desc "List roles"
    get "/" do
      role = paginate Role.all
      present :role, role
    end

    desc "Add role"
    params do
      requires :name, type: String
    end
    # oauth "super_admin"
    post "/" do
      role = Role.find_by(name: params.name)
      error!("Role already exists", env["api.response.code"] = 422) if role.present?

      role = Role.new
      role.name = params.name
      role.code = params.name.parameterize(separator: "_")
      error!(role.errors.full_messages.join(", "), env["api.response.code"] = 422) unless role.save

      present :role, true
    end

    desc "Update role"
    params do
      requires :name, type: String
    end
    # oauth "super_admin"
    put "/:id" do
      role = findRole(params.id)
      role.name = params.name
      role.code = params.name.parameterize(separator: "_")
      error!(role.errors.full_messages.join(", "), env["api.response.code"] = 422) unless role.save

      present :role, role
    end

    desc "Delete role"
    # oauth "super_admin"
    delete "/:id" do
      role = findRole(params.id)
      role.try(:destroy)

      env["api.response.message"] = "Success remove role"
      present :role, nil
    end
  end
end
