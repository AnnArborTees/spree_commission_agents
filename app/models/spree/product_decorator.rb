module Spree
  Product.class_eval do
    has_many :commission_agents

    end
end