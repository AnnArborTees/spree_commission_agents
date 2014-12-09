FactoryGirl.define do
  factory :percent_commission_agent, class: Spree::CommissionAgent do 
    user { |commission_agent| commission_agent.association(:user) }
    product { |product| product.association(:product) }
    calculator_type 'percent'
    rate 20.00

    factory :percent_with_max_one do 
      max 1.0
    end

    factory :percent_with_min_five do 
      min 5.0
    end
  end

  factory :flat_commission_agent, class: Spree::CommissionAgent do 
    user { |commission_agent| commission_agent.association(:user) }
    product { |product| product.association(:product) }
    calculator_type 'flat'
    rate 7.00
  end

end