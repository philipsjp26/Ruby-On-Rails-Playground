class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :user, null: false
      t.decimal :balance, precision: 15, scale: 2, default: 0.0
      t.timestamps
    end
  end
end
