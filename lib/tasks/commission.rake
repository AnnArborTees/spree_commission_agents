namespace :commission do
  task reassign_all_commissions: :environment do
    Spree::CommissionAgent.all.each do |ca|
      ca.line_items.each do |li|
        li.assign_commissions
      end
    end
  end

  task assign_new_commissions: :environment do
    Spree::CommissionAgent.all.each do |ca|
      ca.line_items.each do |li|
        li.assign_commissions if li.commissions.empty?
      end
    end
  end


  task :assign_commissions_for, [:email] => :environment do |_t, args|
    args.with_defaults email: nil

    user = Spree::User.find_by(email: email)
    fail("Couldn't find conmission agent with e-mail #{email}") if user.nil?
    Spree::CommissionAgent.find_by(user_id: user.id).each do |ca|
      ca.line_items.each do |li|
        li.assign_commissions if li.commissions.empty?
      end
    end
  end

end
