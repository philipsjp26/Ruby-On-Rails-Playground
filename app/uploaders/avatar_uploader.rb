class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # storage :file

  # limit file size
  # def size_range
  #   0..2.megabytes
  # end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
    %w(jpg jpeg png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "#{secure_filename}.#{file.extension}" if original_filename.present?
  # end

  # to set where we save our file to Image folder
  def public_id
    return "rbac_development/" + cloudinary_public_id
  end

  private

  def cloudinary_public_id
    Cloudinary::Utils.random_public_id[0..12]
  end

  private

  def secure_filename
    hex = SecureRandom.uuid.split("-")
    hex.join("")
  end
end
