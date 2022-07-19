class Api::V1::Admin::Entities::Users < Grape::Entity
  expose :id
  expose :username
  expose :fullname
  expose :registered_at
  expose :created_at
  expose :menu_actions

  private

  def menu_actions
    object.try(:menu_actions).select(:id, :menu_id, :actions)
  end
end
