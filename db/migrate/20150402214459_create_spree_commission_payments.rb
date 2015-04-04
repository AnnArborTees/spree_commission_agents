class CreateSpreeCommissionPayments < ActiveRecord::Migration
  def change
    create_table :spree_commission_payments do |t|
      t.decimal :amount, scale: 2, precision: 10
      t.date :bring_current_at
      t.integer :user_id
      t.string :payment_method
      t.string :transaction_id
      t.timestamps
    end

    add_index :spree_commission_payments, :user_id
  end
end
