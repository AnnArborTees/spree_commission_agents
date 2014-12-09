module Spree
  User.class_eval do
    has_many :commission_agents

    def comission_products
      comission_agents.map(|ca| ca.product )
    end

    def comission_for_product(product, start_time, end_time)
      # Comission Agents
      # Products
      # Variants
      # Line Items
      # Orders
      # Where completed at
      # Between date  
    end    

  end
end