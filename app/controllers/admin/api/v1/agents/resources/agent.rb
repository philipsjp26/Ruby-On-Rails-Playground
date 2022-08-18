class Admin::Api::V1::Agents::Resources::Agent < Grape::API
  resource "agents" do
    desc "List agents"
    # oauth "super_admin"
    get "/" do
      agent = paginate Agent.all
      present :agent, agent
    end

    desc "Add agent"
    params do
      optional :name, type: String
      requires :privy_id, type: String
      requires :role, type: String
      requires :enabled, type: Boolean, default: false
    end
    # oauth "super_admin"
    post "/" do
      role = ::Role.find_by_code(params.role)
      error!(role.errors.full_messages.join(", "), 422) unless role.present?
      agent = ::Agent.new
      agent.name = params.name if params.name.present?
      agent.privy_id = params.privy_id.downcase
      agent.enable = params.enabled
      agent.roles << role
      error!(agent.errors.full_messages.join(", "), 422) unless agent.save

      present :agent, agent, with: Admin::Api::V1::Agents::Entities::Agent
    end

    desc "Remove agent"
    # oauth "super_admin"
    delete "/:id" do
      agent = Agent.find_by(id: params.id)
      error!("agent not found", env["api.response.code"] = 422) unless agent.present?

      agent.try(:destroy)
      env["api.response.message"] = "Success delete"
      present :agent, nil
    end
  end
end
