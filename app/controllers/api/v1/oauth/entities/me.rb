class Api::V1::Oauth::Entities::Me < Grape::Entity
  expose :id
  expose :username
  expose :created_at
  expose :role
  expose :menus

  private

  def role
    object.roles.select(:id, :name)
  end
end
