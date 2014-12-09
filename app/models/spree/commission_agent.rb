module Spree
  class CommissionAgent < ActiveRecord::Base
  	belongs_to :user
  	belongs_to :product


    def effective_rate(variant = nil)
      variant = product.master if variant.nil?
      return [base_commission(variant), max].min unless max.blank?
      return [base_commission(variant), min].max unless min.blank?
      return base_commission(variant) 
    end

    private

    def base_commission(variant)
      if calculator_type == 'percent'
        return (variant.price * rate * 0.01).round(2)  
      elsif calculator_type == 'flat'
        return rate 
      end
    end

  end
end
