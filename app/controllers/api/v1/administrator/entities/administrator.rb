class Api::V1::Administrator::Entities::Administrator < Grape::Entity
  expose :id
  expose :username
  expose :user_images, as: :profile_image, using: Api::V1::Administrator::Entities::UserImage
  expose :registered_at
  expose :created_at
end
