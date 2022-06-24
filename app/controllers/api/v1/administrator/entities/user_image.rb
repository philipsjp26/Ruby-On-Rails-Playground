class Api::V1::Administrator::Entities::UserImage < Grape::Entity
  expose :id
  expose :url, merge: true

  private

  def url    
    object.try(:profile_image)
  end
end
