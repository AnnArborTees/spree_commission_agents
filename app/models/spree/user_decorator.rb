module Spree
  User.class_eval do
    has_many :commission_agents
    has_many :commission_payments

    def commission_payments_total(start_time = '2014-10-01', end_time = '2030-10-01')
      commission_payments.where("bring_current_at > ? AND bring_current_at < ?", start_time, end_time).sum(:amount)
    end

    def commissions_total(start_time = '2014-10-01', end_time = '2030-10-01')
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:commissions).
          joins(commissions: :line_item).
          joins(commissions: {line_item: :order}).
          where("completed_at > ? AND completed_at < ? and completed_at < '2017-05-10 18:30:18' and completed_at is not null and state = 'complete'", start_time, end_time).sum(:amount)
    end

    def adjustments_total(start_time = '2014-10-01', end_time = '2030-10-01')
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:product).
          joins(product: :variants).
          joins(product: { variants: :line_items }).
          joins(product: { variants: {line_items: :order}}).
          where("completed_at > ? AND completed_at < ? and completed_at < '2017-05-10 18:30:18' and completed_at is not null and state = 'complete'", start_time, end_time).sum('spree_line_items.adjustment_total')
     end

    def sales_total(start_time = '2014-10-01', end_time = nil)
      end_time = "#{end_time} 23:59:59"
      commission_agents.joins(:commissions).
          joins(commissions: :line_item).
          joins(commissions: {line_item: :order}).
          where("completed_at > ? AND completed_at < ? and completed_at < '2017-05-10 18:30:18' and completed_at is not null and state = 'complete'", start_time, end_time).sum(:price)
    end

    def commission_products
      commission_agents.map{|ca| ca.product }
    end

    def commission_balance_as_of(end_time = '2030-10-01')
      commissions_total('2014-10-01', end_time) - commission_payments_total('2014-10-01', end_time)
    end

  end
end
