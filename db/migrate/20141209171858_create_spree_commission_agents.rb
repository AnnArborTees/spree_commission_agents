class CreateSpreeCommissionAgents < ActiveRecord::Migration
  def change
    create_table :spree_commission_agents do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :calculator_type
      t.decimal :rate, precision: 4, scale: 2
      t.decimal :max, precision: 4, scale: 2
      t.decimal :min, precision: 4, scale: 2
      t.timestamps
    end
  end
end
