module Spree
  User.class_eval do
    has_many :commission_agents

    def commission_products
      commission_agents.map{|ca| ca.product }
    end

    def commission_for_product(product, start_time, end_time)
      # Commission Agents
      # Products
      # Variants
      # Line Items
      # Orders
      # Where completed at
      # Between date
    end

  end
end