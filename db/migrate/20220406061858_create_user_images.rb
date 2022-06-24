class CreateUserImages < ActiveRecord::Migration[7.0]
  def change
    create_table :user_images do |t|
      t.string :profile_image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
