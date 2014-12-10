module Spree
  Order.class_eval do 

    def create_comissions
      line_items.each{|li| li.assign_commissions }
    end

  end
end

Spree::Order.state_machine.after_transition :to => :complete,
                                            :do => :create_commissions