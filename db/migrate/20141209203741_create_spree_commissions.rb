class CreateSpreeCommissions < ActiveRecord::Migration
  def change
    create_table :spree_commissions do |t|

      t.timestamps
    end
  end
end
