class AddNewCommissionDashboardUrlToUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :new_commission_dashboard_url, :string
  end
end
