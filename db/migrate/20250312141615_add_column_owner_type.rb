class AddColumnOwnerType < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :owner_type, :string
  end
end
