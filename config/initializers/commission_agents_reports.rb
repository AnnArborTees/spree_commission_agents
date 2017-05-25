Spree::Admin::ReportsController.add_available_report!(:commission_total)
Spree::Admin::ReportsController.add_available_report!(:commission_payment_total)
Spree::Admin::ReportsController.add_available_report!(:commission_balance)

module Spree
  module PermittedAttributes
    @@user_attributes << :new_commission_dashboard_url
  end
end
