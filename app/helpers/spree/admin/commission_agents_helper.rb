module Spree::Admin::CommissionAgentsHelper
  def display_rate(ca)
    if ca.calculator_type == 'percent'
      return number_to_percentage ca.rate, precision: 2
    else
      return number_to_currency(ca.rate)
    end
  end
end
