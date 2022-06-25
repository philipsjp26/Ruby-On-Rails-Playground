class Api::V1::Administrator::Resources::Administrator < Grape::API
  resource :administrator do
    desc "Get List Administrator"
    params do
      optional :q, type: String, desc: "Your key search"
    end
    oauth "super_admin"
    get "/" do
      data = paginate User.all.select(:id, :username, :created_at)

      # puts "check #{env[Grape::Env::API_ENDPOINT].namespace}"

      present :administrator, data
    end

    desc "Get By Id"
    get "/:id" do
      data = User.find_by_id(params.id)
      error!("User not found", env["api.response.code"] = 422) unless data.present?
      present :administrator, data, with: Api::V1::Administrator::Entities::Administrator
    end

    desc "Create users"
    params do
      requires :username, type: String
      requires :email, type: String, allow_blank: false, regexp: /.+@.+/
      requires :password, type: String
      requires :role_id, type: Integer
      optional :profile_image, type: File
    end
    post "/" do
      role = Role.find(params.role_id)

      user = User.new
      user.username = params.username
      user.email = params.email
      user.password = BCrypt::Password.create(params.password)
      user.registered_at = Time.now
      user.roles << role
      error!(user.errors.full_messages.join(", "), 422) unless user.save
      user.user_images.build(profile_image: params.profile_image).try(:save) if params.profile_image.present?

      env["api.response.message"] = "User created"
      present :administrator, nil
    end
  end
end
