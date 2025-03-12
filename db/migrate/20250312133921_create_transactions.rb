class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, foreign_key: { to_table: :wallets }, null: true
      t.references :target_wallet, foreign_key: { to_table: :wallets }, null: true
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :transaction_type, null: false
      t.timestamps
    end
  end
end
