class UserImage < ApplicationRecord
  belongs_to :user

  validates_presence_of :profile_image
  # validates_size_of :profile_image, maximum: 2.megabytes, message: "should be less than 1MB"
  mount_uploader :profile_image, AvatarUploader
end
