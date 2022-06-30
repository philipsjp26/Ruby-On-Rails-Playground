class Api::V1::Oauth::Entities::Me < Grape::Entity
  expose :id
  expose :username
  expose :role

  private

  def role
    object.roles.select(:id, :name)
  end
end
