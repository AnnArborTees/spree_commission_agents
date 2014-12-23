module Spree
  User.class_eval do
    has_many :commission_agents

    def commissions_total(start_time = '2014-12-01', end_time = '2020-12-01')
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:commissions).joins(commissions: :line_item).joins(commissions: {line_item: :order}).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum(:amount)
    end

    def adjustments_total(start_time = '2014-12-01', end_time = '2020-12-01')
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:product).
          joins(product: :variants).
          joins(product: { variants: :line_items }).
          joins(product: { variants: {line_items: :order}}).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum('spree_line_items.adjustment_total')
     end

    def sales_total(start_time = '2014-12-01', end_time = nil)
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:product).
          joins(product: :variants).
          joins(product: { variants: :line_items }).
          joins(product: { variants: {line_items: :order}}).where("completed_at > ? AND completed_at < ? and completed_at is not null", start_time, end_time).sum(:price)
    end

    def commission_products
      commission_agents.map{|ca| ca.product }
    end

  end
end