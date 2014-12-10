namespace :commission do
  task reassign_all_commissions: :environment do
    Spree::CommissionAgent.all.each do |ca|
      ca.line_items.each do |li|
        li.assign_commissions
      end
    end
  end
end
