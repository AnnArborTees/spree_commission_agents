module Spree
  class CommissionAgent < ActiveRecord::Base
  	belongs_to :user
  	belongs_to :product
    has_many :commissions, dependent: :destroy


    def effective_rate(variant = nil, adjustment = 0)
      variant = product.master if variant.nil?
      return [base_commission(variant, adjustment), max].min unless max.blank?
      return [base_commission(variant, adjustment), min].max unless min.blank?
      return base_commission(variant, adjustment)
    end

    def commissions_total(start_time = '2014-12-01', end_time = nil)
      commissions.joins(:line_item).joins(line_item: :order).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum(:amount)
    end

    def sales(start_time = '2014-12-01', end_time = nil)
      product.variants.joins(:line_items).joins(line_items: :order).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum(:price)
    end

    def discounts(start_time = '2014-12-01', end_time = nil)
      product.variants.joins(:line_items).joins(line_items: :order).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum('spree_line_items.adjustment_total')
    end

    def line_items
      Spree::LineItem.joins(:order).joins(:product).joins(product: :commission_agents).where.not(spree_orders: {completed_at: nil}).where(spree_commission_agents: {id: self.id })
    end

    private

    def base_commission(variant, adjustment)
      if calculator_type == 'percent'
        return ((variant.price + adjustment) * rate * 0.01).round(2)
      elsif calculator_type == 'flat'
        return rate
      end
    end

  end
end
