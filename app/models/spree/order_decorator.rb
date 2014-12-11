module Spree
  Order.class_eval do
    after_touch :create_commissions, if: :completed_at?

    def create_commissions
      line_items.each{|li| li.assign_commissions }
    end

  end
end

Spree::Order.state_machine.after_transition :on => :complete,
                                            :do => :create_commissions