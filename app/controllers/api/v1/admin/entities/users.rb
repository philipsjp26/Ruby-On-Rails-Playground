class Api::V1::Admin::Entities::Users < Grape::Entity
  expose :id
  expose :username
  expose :fullname
  expose :registered_at
  expose :created_at
  expose :menu_actions, as: :actions

  private

  def menu_actions
    object.menu_actions.select(:menu_id, :actions)
  end
end
