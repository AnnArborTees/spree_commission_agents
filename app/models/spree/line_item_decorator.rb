module Spree
  LineItem.class_eval do
    has_many :commissions

    def assign_commissions
      variant.commission_agents.each do |ca|
        commission = Spree::Commission.find_or_initialize_by(line_item_id: self.id, commission_agent_id: ca.id)
        commission.amount = ca.effective_rate(variant, self.adjustment_total)
        commission.save
      end
    end

  end
end